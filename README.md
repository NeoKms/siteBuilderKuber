# Автоматическое развертывание мастер-ноды кубернетес. 
# kubelet=1.18.0-00 kubectl=1.18.0-00 kubeadm=1.18.0-00 
# Используется:
- flanel
- ingress
- portainer (NodePort: 30777)
- auto nfs (имя класса: autonfs. Тестовый PVC 1Mi: nfs)
# Для подключения к гитлабу выводится ip, cert, admin token
---
# Для запуска: sh initkuber.sh и через минуту sh kuberInit/init.sh 
## (желательно на чистой машине, например с помощью https://vscale.io/)
# Далее прописать на ip сервера в файле хостс следующие домены:
- __IP__ wss.build.lan api.build.lan preview.build.lan front.build.lan s1.build.lan s2.build.lan s3.build.lan s4.build.lan
## Теперь можно перейти на front.build.lan и пользоваться.
---
# Работа с job-тестами:
*kubectl describe jobs* - вывести всю информацию о работах

*kubectl describe jobs | grep Name:* - вывести только названия работ для удаления\получения логов

*kubectl delete jobs/{name}* - удалить работу

*kubectl logs $(kubectl get pods -n default --selector=job-name={name} --output=jsonpath='{.items[*].metadata.name}')* - получить под по названию работы и вывести из него лог
