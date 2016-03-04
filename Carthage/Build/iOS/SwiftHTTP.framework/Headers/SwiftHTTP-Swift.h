// Generated by Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import Foundation.NSURLSession;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSURLAuthenticationChallenge;
@class NSURLCredential;
@class NSMutableURLRequest;
@class NSURLSessionTask;
@class NSURLSession;
@class NSURLSessionDataTask;
@class NSData;
@class NSError;
@class NSURLSessionDownloadTask;


/// Absorb all the delegates methods of NSURLSession and forwards them to pretty closures. This is basically the sin eater for NSURLSession.
SWIFT_CLASS("_TtC9SwiftHTTP15DelegateManager")
@interface DelegateManager : NSObject <NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>
+ (DelegateManager * __nonnull)sharedInstance;

/// this is for global authenication handling
@property (nonatomic, copy) NSURLCredential * __nullable (^ __nullable auth)(NSURLAuthenticationChallenge * __nonnull);

/// this is for global request handling
@property (nonatomic, copy) void (^ __nullable requestHandler)(NSMutableURLRequest * __nonnull);
- (void)removeTask:(NSURLSessionTask * __nonnull)task;
- (void)addResponseForTask:(NSURLSessionTask * __nonnull)task;
- (void)URLSession:(NSURLSession * __nonnull)session dataTask:(NSURLSessionDataTask * __nonnull)dataTask didReceiveData:(NSData * __nonnull)data;
- (void)URLSession:(NSURLSession * __nonnull)session task:(NSURLSessionTask * __nonnull)task didCompleteWithError:(NSError * __nullable)error;
- (void)URLSession:(NSURLSession * __nonnull)session task:(NSURLSessionTask * __nonnull)task didReceiveChallenge:(NSURLAuthenticationChallenge * __nonnull)challenge completionHandler:(void (^ __nonnull)(NSURLSessionAuthChallengeDisposition, NSURLCredential * __nullable))completionHandler;
- (void)URLSession:(NSURLSession * __nonnull)session task:(NSURLSessionTask * __nonnull)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend;
- (void)URLSession:(NSURLSession * __nonnull)session downloadTask:(NSURLSessionDownloadTask * __nonnull)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class NSURLRequest;


/// The class that does the magic. Is a subclass of NSOperation so you can use it with operation queues or just a good ole HTTP request.
SWIFT_CLASS("_TtC9SwiftHTTP4HTTP")
@interface HTTP : NSOperation

/// This is for handling authenication
@property (nonatomic, copy) NSURLCredential * __nullable (^ __nullable auth)(NSURLAuthenticationChallenge * __nonnull);

/// This is for monitoring progress
@property (nonatomic, copy) void (^ __nullable progress)(float);

/// the actual task
@property (nonatomic, strong) NSURLSessionDataTask * __null_unspecified task;
+ (NSSet * __nonnull)keyPathsForValuesAffectingIsReady;
+ (NSSet * __nonnull)keyPathsForValuesAffectingIsExecuting;
+ (NSSet * __nonnull)keyPathsForValuesAffectingIsFinished;

/// creates a new HTTP request.
- (nonnull instancetype)init:(NSURLRequest * __nonnull)req session:(NSURLSession * __nonnull)session OBJC_DESIGNATED_INITIALIZER;

/// Returns if the task is asynchronous or not. NSURLSessionTask requests are asynchronous.
@property (nonatomic, readonly, getter=isAsynchronous) BOOL asynchronous;
@property (nonatomic, readonly, getter=isReady) BOOL ready;

/// Returns if the task is current running.
@property (nonatomic, readonly, getter=isExecuting) BOOL executing;
@property (nonatomic, readonly, getter=isFinished) BOOL finished;

/// Start the HTTP task. Make sure to set the onFinish closure before calling this to get a response.
- (void)start;

/// Cancel the running task
- (void)cancel;

/// Sets the task to finished. If you aren't using the DelegateManager, you will have to call this in your delegate's URLSession:dataTask:didCompleteWithError: method
- (void)finish;

/// Check not executing or finished when adding dependencies
- (void)addDependency:(NSOperation * __nonnull)operation;

/// Convenience bool to flag as operation userInitiated if necessary
@property (nonatomic) BOOL userInitiated;

/// Set the global auth handler
+ (void)globalAuth:(NSURLCredential * __nullable (^ __nullable)(NSURLAuthenticationChallenge * __nonnull))handler;

/// Set the global request handler
+ (void)globalRequest:(void (^ __nullable)(NSMutableURLRequest * __nonnull))handler;
@end


@interface NSLock (SWIFT_EXTENSION(SwiftHTTP))
@end


@interface NSMutableURLRequest (SWIFT_EXTENSION(SwiftHTTP))

/// Convenience init to allow init with a string. -parameter urlString: The string representation of a URL to init with.
- (nullable instancetype)initWithUrlString:(NSString * __nonnull)urlString;

/// Used to update the content type in the HTTP header as needed
@property (nonatomic, readonly, copy) NSString * __nonnull contentTypeKey;

/// Helper method to create the multipart form data
- (NSString * __nonnull)multiFormHeader:(NSString * __nonnull)name fileName:(NSString * __nullable)fileName type:(NSString * __nullable)type multiCRLF:(NSString * __nonnull)multiCRLF;

/// Check if the request requires the parameters to be appended to the URL
- (BOOL)isURIParam;
@end

@class NSURL;
@class NSCoder;


/// This is how to upload files in SwiftHTTP. The upload object represents a file to upload by either a data blob or a url (which it reads off disk).
SWIFT_CLASS("_TtC9SwiftHTTP6Upload")
@interface Upload : NSObject <NSCoding>
@property (nonatomic, strong) NSURL * __nullable fileUrl;
@property (nonatomic, copy) NSString * __nullable mimeType;
@property (nonatomic, strong) NSData * __nullable data;
@property (nonatomic, copy) NSString * __nullable fileName;

/// Tries to determine the mime type from the fileUrl extension.
- (void)getMimeType;

/// Reads the data from disk or from memory. Throws an error if no data or file is found.
- (NSData * __nullable)getDataAndReturnError:(NSError * __nullable * __null_unspecified)error;

/// Standard NSCoder support
- (void)encodeWithCoder:(NSCoder * __nonnull)aCoder;

/// Required for NSObject support (because of NSCoder, it would be a struct otherwise!)
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder;

/// Initializes a new Upload object with a fileUrl. The fileName and mimeType will be infered.
///
/// -parameter fileUrl: The fileUrl is a standard url path to a file.
- (nonnull instancetype)initWithFileUrl:(NSURL * __nonnull)fileUrl;

/// Initializes a new Upload object with a data blob.
///
/// -parameter data: The data is a NSData representation of a file's data.
/// -parameter fileName: The fileName is just that. The file's name.
/// -parameter mimeType: The mimeType is just that. The mime type you would like the file to uploaded as.
///
/// upload a file from a a data blob. Must add a filename and mimeType as that can't be infered from the data
- (nonnull instancetype)initWithData:(NSData * __nonnull)data fileName:(NSString * __nonnull)fileName mimeType:(NSString * __nonnull)mimeType;
@end


@interface Upload (SWIFT_EXTENSION(SwiftHTTP))
@end

#pragma clang diagnostic pop
