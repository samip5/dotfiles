function whn --description 'delete the fucking hook'
   kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
end
