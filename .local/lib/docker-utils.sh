_dockerhub-login () {
	curl -fsSL -X POST \
		--header "Content-Type: application/json" \
		--data @<(envsubst <./dockerhub-creds.json) \
		"https://hub.docker.com/v2/users/login/"
}

_fetch-docker-bearer-token () {
	repo="${1?must specify image repo}"
	[[ "$repo" != *"/"* ]] && repo="library/$repo" # default namespace
	curl -fsSL -X GET \
		"https://auth.docker.io/token?service=registry.docker.io&scope=repository:${repo}:pull"
}

cleanup-docker-containers() {
        local status_filter=${1:-exited}
        local containers="$(docker ps -qa --filter status=$status_filter)"
        [[ -z "$containers" ]] || docker rm $containers
}

cleanup-docker-images() {
        local images="$(docker images --filter dangling=true -q)"
        [[ -z "$images" ]] || docker rmi $images
        images="$(docker images | awk '/none/ { print $3 }')"
        [[ -z "$images" ]] || docker rmi $images
}

cleanup-docker-repos() {
        local repo_name=${1:?exact repository name required}
        local images="$(docker images -q $repo_name | sort -u)"
        [[ -z "$images" ]] || docker rmi $images -f
}

docker-id-for() {
        docker ps -a --no-trunc | awk -v pattern="$1" '$0 ~ pattern {print $1}'
}
