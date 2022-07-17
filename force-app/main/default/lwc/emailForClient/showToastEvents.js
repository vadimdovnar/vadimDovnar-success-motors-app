
export function showToastSuccess( ShowToastEvent, contEmail ) {
    const event = new ShowToastEvent({
        title: 'Email sent successfully',
        variant: 'success',
        message:
            'Contact Email : ' + contEmail,
    });
    this.dispatchEvent(event);
}
export function showToastError( ShowToastEvent, contEmail ) {
    const event = new ShowToastEvent({
        title: 'Email not sent',
        variant: 'error',
        message:
            'Contact Email : ' + contEmail,
    });
    this.dispatchEvent(event);
}