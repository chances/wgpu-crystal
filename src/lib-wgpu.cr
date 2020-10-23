@[Link(ldflags: "-L#{__DIR__}/../bin/libs -lwgpu_native")]
lib LibWGPU
  WGPUCOPY_BYTES_PER_ROW_ALIGNMENT = 256
  WGPUDESIRED_NUM_FRAMES = 3
  WGPUMAX_ANISOTROPY = 16
  WGPUMAX_COLOR_TARGETS = 4
  WGPUMAX_MIP_LEVELS = 16
  WGPUMAX_VERTEX_BUFFERS = 16
  # WGPUFeatures_MAPPABLE_PRIMARY_BUFFERS = ( uint64_t)65536
  # WGPUFeatures_SAMPLED_TEXTURE_BINDING_ARRAY = ( uint64_t)131072
  # WGPUFeatures_SAMPLED_TEXTURE_ARRAY_DYNAMIC_INDEXING = ( uint64_t)262144
  # WGPUFeatures_SAMPLED_TEXTURE_ARRAY_NON_UNIFORM_INDEXING = ( uint64_t)524288
  # WGPUFeatures_UNSIZED_BINDING_ARRAY = ( uint64_t)1048576
  # WGPUFeatures_MULTI_DRAW_INDIRECT = ( uint64_t)2097152
  # WGPUFeatures_MULTI_DRAW_INDIRECT_COUNT = ( uint64_t)4194304
  # WGPUFeatures_ALL_WEBGPU = ( uint64_t)65535
  # WGPUFeatures_ALL_UNSAFE = ( uint64_t)ULongLong.new(18446462598732840960)
  # WGPUFeatures_ALL_NATIVE = ( uint64_t)ULongLong.new(18446744073709486080)
  # WGPUColor_TRANSPARENT = ( WGPUColor){. r=0.0,. g=0.0,. b=0.0,. a=0.0}
  # WGPUColor_BLACK = ( WGPUColor){. r=0.0,. g=0.0,. b=0.0,. a=1.0}
  # WGPUColor_WHITE = ( WGPUColor){. r=1.0,. g=1.0,. b=1.0,. a=1.0}
  # WGPUColor_RED = ( WGPUColor){. r=1.0,. g=0.0,. b=0.0,. a=1.0}
  # WGPUColor_GREEN = ( WGPUColor){. r=0.0,. g=1.0,. b=0.0,. a=1.0}
  # WGPUColor_BLUE = ( WGPUColor){. r=0.0,. g=0.0,. b=1.0,. a=1.0}
  # WGPUOrigin3d_ZERO = ( WGPUOrigin3d){. x=0,. y=0,. z=0}
  # WGPUShaderStage_NONE = ( uint32_t)0
  # WGPUShaderStage_VERTEX = ( uint32_t)1
  # WGPUShaderStage_FRAGMENT = ( uint32_t)2
  # WGPUShaderStage_COMPUTE = ( uint32_t)4
  # WGPUBufferUsage_MAP_READ = ( uint32_t)1
  # WGPUBufferUsage_MAP_WRITE = ( uint32_t)2
  # WGPUBufferUsage_COPY_SRC = ( uint32_t)4
  # WGPUBufferUsage_COPY_DST = ( uint32_t)8
  # WGPUBufferUsage_INDEX = ( uint32_t)16
  # WGPUBufferUsage_VERTEX = ( uint32_t)32
  # WGPUBufferUsage_UNIFORM = ( uint32_t)64
  # WGPUBufferUsage_STORAGE = ( uint32_t)128
  # WGPUBufferUsage_INDIRECT = ( uint32_t)256
  # WGPUColorWrite_RED = ( uint32_t)1
  # WGPUColorWrite_GREEN = ( uint32_t)2
  # WGPUColorWrite_BLUE = ( uint32_t)4
  # WGPUColorWrite_ALPHA = ( uint32_t)8
  # WGPUColorWrite_COLOR = ( uint32_t)7
  # WGPUColorWrite_ALL = ( uint32_t)15
  # WGPUTextureUsage_COPY_SRC = ( uint32_t)1
  # WGPUTextureUsage_COPY_DST = ( uint32_t)2
  # WGPUTextureUsage_SAMPLED = ( uint32_t)4
  # WGPUTextureUsage_STORAGE = ( uint32_t)8
  # WGPUTextureUsage_OUTPUT_ATTACHMENT = ( uint32_t)16
  alias WGPUNonZeroU64 = UInt64
  alias WGPUOption_NonZeroU32 = UInt32
  alias WGPUOption_NonZeroU64 = UInt64
  alias WGPUOption_BufferSize = WGPUOption_NonZeroU64
  alias WGPUOption_AdapterId = UInt64
  alias WGPUOption_BufferId = UInt64
  alias WGPUOption_SamplerId = UInt64
  alias WGPUOption_SurfaceId = UInt64
  alias WGPUOption_TextureViewId = UInt64
  enum WGPUAddressMode : UInt8
    ClampToEdge = 0
    Repeat = 1
    MirrorRepeat = 2
  end
  enum WGPUBackend : UInt8
    Empty = 0
    Vulkan = 1
    Metal = 2
    Dx12 = 3
    Dx11 = 4
    Gl = 5
    BrowserWebGpu = 6
  end
  enum WGPUBindingType : UInt32
    UniformBuffer = 0
    StorageBuffer = 1
    ReadonlyStorageBuffer = 2
    Sampler = 3
    ComparisonSampler = 4
    SampledTexture = 5
    ReadonlyStorageTexture = 6
    WriteonlyStorageTexture = 7
  end
  enum WGPUBlendFactor : UInt8
    Zero = 0
    One = 1
    SrcColor = 2
    OneMinusSrcColor = 3
    SrcAlpha = 4
    OneMinusSrcAlpha = 5
    DstColor = 6
    OneMinusDstColor = 7
    DstAlpha = 8
    OneMinusDstAlpha = 9
    SrcAlphaSaturated = 10
    BlendColor = 11
    OneMinusBlendColor = 12
  end
  enum WGPUBlendOperation : UInt8
    Add = 0
    Subtract = 1
    ReverseSubtract = 2
    Min = 3
    Max = 4
  end
  enum WGPUBufferMapAsyncStatus : UInt8
    Success = 0
    Error = 1
    Unknown = 2
    ContextLost = 3
  end
  enum WGPUCDeviceType : UInt8
    Other = 0
    IntegratedGpu = 1
    DiscreteGpu = 2
    VirtualGpu = 3
    Cpu = 4
  end
  enum WGPUCompareFunction : UInt8
    Undefined = 0
    Never = 1
    Less = 2
    Equal = 3
    LessEqual = 4
    Greater = 5
    NotEqual = 6
    GreaterEqual = 7
    Always = 8
  end
  enum WGPUCullMode : UInt8
    None = 0
    Front = 1
    Back = 2
  end
  enum WGPUFilterMode : UInt8
    Nearest = 0
    Linear = 1
  end
  enum WGPUFrontFace : UInt8
    Ccw = 0
    Cw = 1
  end
  enum WGPUIndexFormat : UInt8
    Uint16 = 0
    Uint32 = 1
  end
  enum WGPUInputStepMode : UInt8
    Vertex = 0
    Instance = 1
  end
  enum WGPULoadOp : UInt8
    Clear = 0
    Load = 1
  end
  enum WGPULogLevel : UInt8
    Off = 0
    Error = 1
    Warn = 2
    Info = 3
    Debug = 4
    Trace = 5
  end
  enum WGPUPowerPreference : UInt8
    Default = 0
    LowPower = 1
    HighPerformance = 2
  end
  enum WGPUPresentMode : UInt8
    Immediate = 0
    Mailbox = 1
    Fifo = 2
  end
  enum WGPUPrimitiveTopology : UInt8
    PointList = 0
    LineList = 1
    LineStrip = 2
    TriangleList = 3
    TriangleStrip = 4
  end
  enum WGPUSType : UInt32
    Invalid = 0
    SurfaceDescriptorFromMetalLayer = 1
    SurfaceDescriptorFromWindowsHWND = 2
    SurfaceDescriptorFromXlib = 3
    SurfaceDescriptorFromHTMLCanvasId = 4
    ShaderModuleSPIRVDescriptor = 5
    ShaderModuleWGSLDescriptor = 6
    AnisotropicFiltering = 268435456
    Force32 = 2147483647
  end
  enum WGPUStencilOperation : UInt8
    Keep = 0
    Zero = 1
    Replace = 2
    Invert = 3
    IncrementClamp = 4
    DecrementClamp = 5
    IncrementWrap = 6
    DecrementWrap = 7
  end
  enum WGPUStoreOp : UInt8
    Clear = 0
    Store = 1
  end
  enum WGPUSwapChainStatus : UInt8
    Good = 0
    Suboptimal = 1
    Timeout = 2
    Outdated = 3
    Lost = 4
    OutOfMemory = 5
  end
  enum WGPUTextureAspect : UInt8
    All = 0
    StencilOnly = 1
    DepthOnly = 2
  end
  enum WGPUTextureComponentType : UInt8
    Float = 0
    Sint = 1
    Uint = 2
  end
  enum WGPUTextureDimension : UInt8
    D1 = 0
    D2 = 1
    D3 = 2
  end
  enum WGPUTextureFormat : UInt8
    R8Unorm = 0
    R8Snorm = 1
    R8Uint = 2
    R8Sint = 3
    R16Uint = 4
    R16Sint = 5
    R16Float = 6
    Rg8Unorm = 7
    Rg8Snorm = 8
    Rg8Uint = 9
    Rg8Sint = 10
    R32Uint = 11
    R32Sint = 12
    R32Float = 13
    Rg16Uint = 14
    Rg16Sint = 15
    Rg16Float = 16
    Rgba8Unorm = 17
    Rgba8UnormSrgb = 18
    Rgba8Snorm = 19
    Rgba8Uint = 20
    Rgba8Sint = 21
    Bgra8Unorm = 22
    Bgra8UnormSrgb = 23
    Rgb10a2Unorm = 24
    Rg11b10Float = 25
    Rg32Uint = 26
    Rg32Sint = 27
    Rg32Float = 28
    Rgba16Uint = 29
    Rgba16Sint = 30
    Rgba16Float = 31
    Rgba32Uint = 32
    Rgba32Sint = 33
    Rgba32Float = 34
    Depth32Float = 35
    Depth24Plus = 36
    Depth24PlusStencil8 = 37
  end
  enum WGPUTextureViewDimension : UInt8
    D1 = 0
    D2 = 1
    D2Array = 2
    Cube = 3
    CubeArray = 4
    D3 = 5
  end
  enum WGPUVertexFormat : UInt8
    Uchar2 = 0
    Uchar4 = 1
    Char2 = 2
    Char4 = 3
    Uchar2Norm = 4
    Uchar4Norm = 5
    Char2Norm = 6
    Char4Norm = 7
    Ushort2 = 8
    Ushort4 = 9
    Short2 = 10
    Short4 = 11
    Ushort2Norm = 12
    Ushort4Norm = 13
    Short2Norm = 14
    Short4Norm = 15
    Half2 = 16
    Half4 = 17
    Float = 18
    Float2 = 19
    Float3 = 20
    Float4 = 21
    Uint = 22
    Uint2 = 23
    Uint3 = 24
    Uint4 = 25
    Int = 26
    Int2 = 27
    Int3 = 28
    Int4 = 29
  end
  type WGPUComputePass = Void
  type WGPURenderBundleEncoder = Void
  type WGPURenderPass = Void
  alias WGPUId_Adapter_Dummy = WGPUNonZeroU64
  alias WGPUAdapterId = WGPUId_Adapter_Dummy
  alias WGPUFeatures = UInt64
  struct WGPUCAdapterInfo
    name : Char*
    name_length : LibC::SizeT
    vendor : LibC::SizeT
    device : LibC::SizeT
    device_type : WGPUCDeviceType
    backend : WGPUBackend
  end
  struct WGPUCLimits
    max_bind_groups : UInt32
  end
  alias WGPUId_Device_Dummy = WGPUNonZeroU64
  alias WGPUDeviceId = WGPUId_Device_Dummy
  alias WGPUId_BindGroup_Dummy = WGPUNonZeroU64
  alias WGPUBindGroupId = WGPUId_BindGroup_Dummy
  alias WGPUId_BindGroupLayout_Dummy = WGPUNonZeroU64
  alias WGPUBindGroupLayoutId = WGPUId_BindGroupLayout_Dummy
  alias WGPUId_Buffer_Dummy = WGPUNonZeroU64
  alias WGPUBufferId = WGPUId_Buffer_Dummy
  alias WGPUBufferAddress = UInt64
  alias WGPUBufferSize = WGPUNonZeroU64
  alias WGPUBufferMapCallback = (WGPUBufferMapAsyncStatus, UInt8*) -> Void
  alias WGPUId_CommandBuffer_Dummy = WGPUNonZeroU64
  alias WGPUCommandBufferId = WGPUId_CommandBuffer_Dummy
  alias WGPUCommandEncoderId = WGPUCommandBufferId
  struct WGPUComputePassDescriptor
    todo : UInt32
  end
  alias WGPUId_TextureView_Dummy = WGPUNonZeroU64
  alias WGPUTextureViewId = WGPUId_TextureView_Dummy
  struct WGPUColor
    r : Float64
    g : Float64
    b : Float64
    a : Float64
  end
  struct WGPUPassChannel_Color
    load_op : WGPULoadOp
    store_op : WGPUStoreOp
    clear_value : WGPUColor
    read_only : Bool
  end
  struct WGPURenderPassColorAttachmentDescriptorBase_TextureViewId
    attachment : WGPUTextureViewId
    resolve_target : WGPUOption_TextureViewId
    channel : WGPUPassChannel_Color
  end
  alias WGPURenderPassColorAttachmentDescriptor = WGPURenderPassColorAttachmentDescriptorBase_TextureViewId
  struct WGPUPassChannel_f32
    load_op : WGPULoadOp
    store_op : WGPUStoreOp
    clear_value : Float32
    read_only : Bool
  end
  struct WGPUPassChannel_u32
    load_op : WGPULoadOp
    store_op : WGPUStoreOp
    clear_value : UInt32
    read_only : Bool
  end
  struct WGPURenderPassDepthStencilAttachmentDescriptorBase_TextureViewId
    attachment : WGPUTextureViewId
    depth : WGPUPassChannel_f32
    stencil : WGPUPassChannel_u32
  end
  alias WGPURenderPassDepthStencilAttachmentDescriptor = WGPURenderPassDepthStencilAttachmentDescriptorBase_TextureViewId
  struct WGPURenderPassDescriptor
    color_attachments : WGPURenderPassColorAttachmentDescriptor*
    color_attachments_length : LibC::SizeT
    depth_stencil_attachment : WGPURenderPassDepthStencilAttachmentDescriptor*
  end
  struct WGPUTextureDataLayout
    offset : WGPUBufferAddress
    bytes_per_row : UInt32
    rows_per_image : UInt32
  end
  struct WGPUBufferCopyView
    buffer : WGPUBufferId
    layout : WGPUTextureDataLayout
  end
  alias WGPUId_Texture_Dummy = WGPUNonZeroU64
  alias WGPUTextureId = WGPUId_Texture_Dummy
  struct WGPUOrigin3d
    x : UInt32
    y : UInt32
    z : UInt32
  end
  struct WGPUTextureCopyView
    texture : WGPUTextureId
    mip_level : UInt32
    origin : WGPUOrigin3d
  end
  struct WGPUExtent3d
    width : UInt32
    height : UInt32
    depth : UInt32
  end
  struct WGPUCommandBufferDescriptor
    todo : UInt32
  end
  alias WGPURawString = Char*
  alias WGPUDynamicOffset = UInt32
  alias WGPUId_ComputePipeline_Dummy = WGPUNonZeroU64
  alias WGPUComputePipelineId = WGPUId_ComputePipeline_Dummy
  alias WGPUId_Surface = WGPUNonZeroU64
  alias WGPUSurfaceId = WGPUId_Surface
  alias WGPULabel = Char*
  struct WGPUBindGroupEntry
    binding : UInt32
    buffer : WGPUOption_BufferId
    offset : WGPUBufferAddress
    size : WGPUBufferSize
    sampler : WGPUOption_SamplerId
    texture_view : WGPUOption_TextureViewId
  end
  struct WGPUBindGroupDescriptor
    label : WGPULabel
    layout : WGPUBindGroupLayoutId
    entries : WGPUBindGroupEntry*
    entries_length : LibC::SizeT
  end
  alias WGPUShaderStage = UInt32
  struct WGPUBindGroupLayoutEntry
    binding : UInt32
    visibility : WGPUShaderStage
    ty : WGPUBindingType
    has_dynamic_offset : Bool
    min_buffer_binding_size : WGPUOption_NonZeroU64
    multisampled : Bool
    view_dimension : WGPUTextureViewDimension
    texture_component_type : WGPUTextureComponentType
    storage_texture_format : WGPUTextureFormat
    count : WGPUOption_NonZeroU32
  end
  struct WGPUBindGroupLayoutDescriptor
    label : WGPULabel
    entries : WGPUBindGroupLayoutEntry*
    entries_length : LibC::SizeT
  end
  alias WGPUBufferUsage = UInt32
  struct WGPUBufferDescriptor
    label : WGPULabel
    size : WGPUBufferAddress
    usage : WGPUBufferUsage
    mapped_at_creation : Bool
  end
  struct WGPUCommandEncoderDescriptor
    label : WGPULabel
  end
  alias WGPUId_PipelineLayout_Dummy = WGPUNonZeroU64
  alias WGPUPipelineLayoutId = WGPUId_PipelineLayout_Dummy
  alias WGPUId_ShaderModule_Dummy = WGPUNonZeroU64
  alias WGPUShaderModuleId = WGPUId_ShaderModule_Dummy
  struct WGPUProgrammableStageDescriptor
    module : WGPUShaderModuleId
    entry_point : WGPURawString
  end
  struct WGPUComputePipelineDescriptor
    layout : WGPUPipelineLayoutId
    compute_stage : WGPUProgrammableStageDescriptor
  end
  struct WGPUPipelineLayoutDescriptor
    bind_group_layouts : WGPUBindGroupLayoutId*
    bind_group_layouts_length : LibC::SizeT
  end
  alias WGPURenderBundleEncoderId = WGPURenderBundleEncoder*
  struct WGPURenderBundleEncoderDescriptor
    label : WGPULabel
    color_formats : WGPUTextureFormat*
    color_formats_length : LibC::SizeT
    depth_stencil_format : WGPUTextureFormat*
    sample_count : UInt32
  end
  alias WGPUId_RenderPipeline_Dummy = WGPUNonZeroU64
  alias WGPURenderPipelineId = WGPUId_RenderPipeline_Dummy
  struct WGPURasterizationStateDescriptor
    front_face : WGPUFrontFace
    cull_mode : WGPUCullMode
    depth_bias : Int32
    depth_bias_slope_scale : Float32
    depth_bias_clamp : Float32
  end
  struct WGPUBlendDescriptor
    src_factor : WGPUBlendFactor
    dst_factor : WGPUBlendFactor
    operation : WGPUBlendOperation
  end
  alias WGPUColorWrite = UInt32
  struct WGPUColorStateDescriptor
    format : WGPUTextureFormat
    alpha_blend : WGPUBlendDescriptor
    color_blend : WGPUBlendDescriptor
    write_mask : WGPUColorWrite
  end
  struct WGPUStencilStateFaceDescriptor
    compare : WGPUCompareFunction
    fail_op : WGPUStencilOperation
    depth_fail_op : WGPUStencilOperation
    pass_op : WGPUStencilOperation
  end
  struct WGPUDepthStencilStateDescriptor
    format : WGPUTextureFormat
    depth_write_enabled : Bool
    depth_compare : WGPUCompareFunction
    stencil_front : WGPUStencilStateFaceDescriptor
    stencil_back : WGPUStencilStateFaceDescriptor
    stencil_read_mask : UInt32
    stencil_write_mask : UInt32
  end
  alias WGPUShaderLocation = UInt32
  struct WGPUVertexAttributeDescriptor
    offset : WGPUBufferAddress
    format : WGPUVertexFormat
    shader_location : WGPUShaderLocation
  end
  struct WGPUVertexBufferLayoutDescriptor
    array_stride : WGPUBufferAddress
    step_mode : WGPUInputStepMode
    attributes : WGPUVertexAttributeDescriptor*
    attributes_length : LibC::SizeT
  end
  struct WGPUVertexStateDescriptor
    index_format : WGPUIndexFormat
    vertex_buffers : WGPUVertexBufferLayoutDescriptor*
    vertex_buffers_length : LibC::SizeT
  end
  struct WGPURenderPipelineDescriptor
    layout : WGPUPipelineLayoutId
    vertex_stage : WGPUProgrammableStageDescriptor
    fragment_stage : WGPUProgrammableStageDescriptor*
    primitive_topology : WGPUPrimitiveTopology
    rasterization_state : WGPURasterizationStateDescriptor*
    color_states : WGPUColorStateDescriptor*
    color_states_length : LibC::SizeT
    depth_stencil_state : WGPUDepthStencilStateDescriptor*
    vertex_state : WGPUVertexStateDescriptor
    sample_count : UInt32
    sample_mask : UInt32
    alpha_to_coverage_enabled : Bool
  end
  alias WGPUId_Sampler_Dummy = WGPUNonZeroU64
  alias WGPUSamplerId = WGPUId_Sampler_Dummy
  struct WGPUChainedStruct
    next : WGPUChainedStruct*
    s_type : WGPUSType
  end
  struct WGPUSamplerDescriptor
    next_in_chain : WGPUChainedStruct*
    label : WGPULabel
    address_mode_u : WGPUAddressMode
    address_mode_v : WGPUAddressMode
    address_mode_w : WGPUAddressMode
    mag_filter : WGPUFilterMode
    min_filter : WGPUFilterMode
    mipmap_filter : WGPUFilterMode
    lod_min_clamp : Float32
    lod_max_clamp : Float32
    compare : WGPUCompareFunction
  end
  struct WGPUShaderSource
    bytes : UInt32*
    length : LibC::SizeT
  end
  alias WGPUId_SwapChain_Dummy = WGPUNonZeroU64
  alias WGPUSwapChainId = WGPUId_SwapChain_Dummy
  alias WGPUTextureUsage = UInt32
  struct WGPUSwapChainDescriptor
    usage : WGPUTextureUsage
    format : WGPUTextureFormat
    width : UInt32
    height : UInt32
    present_mode : WGPUPresentMode
  end
  struct WGPUTextureDescriptor
    label : WGPULabel
    size : WGPUExtent3d
    mip_level_count : UInt32
    sample_count : UInt32
    dimension : WGPUTextureDimension
    format : WGPUTextureFormat
    usage : WGPUTextureUsage
  end
  alias WGPUQueueId = WGPUDeviceId
  alias WGPUId_RenderBundle = WGPUNonZeroU64
  alias WGPURenderBundleId = WGPUId_RenderBundle
  struct WGPURenderBundleDescriptor_Label
    label : WGPULabel
  end
  struct WGPURequestAdapterOptions
    power_preference : WGPUPowerPreference
    compatible_surface : WGPUOption_SurfaceId
  end
  alias WGPUBackendBit = UInt32
  alias WGPURequestAdapterCallback = (WGPUOption_AdapterId, Void*) -> Void
  alias WGPULogCallback = (Int32, Char*) -> Void
  struct WGPUSwapChainOutput
    status : WGPUSwapChainStatus
    view_id : WGPUOption_TextureViewId
  end
  struct WGPUTextureViewDescriptor
    label : WGPULabel
    format : WGPUTextureFormat
    dimension : WGPUTextureViewDimension
    aspect : WGPUTextureAspect
    base_mip_level : UInt32
    level_count : UInt32
    base_array_layer : UInt32
    array_layer_count : UInt32
  end
  struct WGPUAnisotropicSamplerDescriptorExt
    next_in_chain : WGPUChainedStruct*
    s_type : WGPUSType
    anisotropic_clamp : UInt8
  end
  fun wgpu_adapter_destroy(WGPUAdapterId) : Void
  fun wgpu_adapter_features(WGPUAdapterId) : WGPUFeatures
  fun wgpu_adapter_get_info(WGPUAdapterId, WGPUCAdapterInfo*) : Void
  fun wgpu_adapter_limits(WGPUAdapterId) : WGPUCLimits
  fun wgpu_adapter_request_device(WGPUAdapterId, WGPUFeatures, WGPUCLimits*, Bool, Char*) : WGPUDeviceId
  fun wgpu_bind_group_destroy(WGPUBindGroupId) : Void
  fun wgpu_bind_group_layout_destroy(WGPUBindGroupLayoutId) : Void
  fun wgpu_buffer_destroy(WGPUBufferId) : Void
  fun wgpu_buffer_get_mapped_range(WGPUBufferId, WGPUBufferAddress, WGPUBufferSize) : UInt8*
  fun wgpu_buffer_map_read_async(WGPUBufferId, WGPUBufferAddress, WGPUBufferAddress, WGPUBufferMapCallback, UInt8*) : Void
  fun wgpu_buffer_map_write_async(WGPUBufferId, WGPUBufferAddress, WGPUBufferAddress, WGPUBufferMapCallback, UInt8*) : Void
  fun wgpu_buffer_unmap(WGPUBufferId) : Void
  fun wgpu_command_buffer_destroy(WGPUCommandBufferId) : Void
  fun wgpu_command_encoder_begin_compute_pass(WGPUCommandEncoderId, WGPUComputePassDescriptor*) : WGPUComputePass*
  fun wgpu_command_encoder_begin_render_pass(WGPUCommandEncoderId, WGPURenderPassDescriptor*) : WGPURenderPass*
  fun wgpu_command_encoder_copy_buffer_to_buffer(WGPUCommandEncoderId, WGPUBufferId, WGPUBufferAddress, WGPUBufferId, WGPUBufferAddress, WGPUBufferAddress) : Void
  fun wgpu_command_encoder_copy_buffer_to_texture(WGPUCommandEncoderId, WGPUBufferCopyView*, WGPUTextureCopyView*, WGPUExtent3d*) : Void
  fun wgpu_command_encoder_copy_texture_to_buffer(WGPUCommandEncoderId, WGPUTextureCopyView*, WGPUBufferCopyView*, WGPUExtent3d*) : Void
  fun wgpu_command_encoder_copy_texture_to_texture(WGPUCommandEncoderId, WGPUTextureCopyView*, WGPUTextureCopyView*, WGPUExtent3d*) : Void
  fun wgpu_command_encoder_destroy(WGPUCommandEncoderId) : Void
  fun wgpu_command_encoder_finish(WGPUCommandEncoderId, WGPUCommandBufferDescriptor*) : WGPUCommandBufferId
  fun wgpu_compute_pass_destroy(WGPUComputePass*) : Void
  fun wgpu_compute_pass_dispatch(WGPUComputePass*, UInt32, UInt32, UInt32) : Void
  fun wgpu_compute_pass_dispatch_indirect(WGPUComputePass*, WGPUBufferId, WGPUBufferAddress) : Void
  fun wgpu_compute_pass_end_pass(WGPUComputePass*) : Void
  fun wgpu_compute_pass_insert_debug_marker(WGPUComputePass*, WGPURawString, UInt32) : Void
  fun wgpu_compute_pass_pop_debug_group(WGPUComputePass*) : Void
  fun wgpu_compute_pass_push_debug_group(WGPUComputePass*, WGPURawString, UInt32) : Void
  fun wgpu_compute_pass_set_bind_group(WGPUComputePass*, UInt32, WGPUBindGroupId, WGPUDynamicOffset*, LibC::SizeT) : Void
  fun wgpu_compute_pass_set_pipeline(WGPUComputePass*, WGPUComputePipelineId) : Void
  fun wgpu_compute_pipeline_destroy(WGPUComputePipelineId) : Void
  fun wgpu_create_surface_from_android(Void*) : WGPUSurfaceId
  fun wgpu_create_surface_from_metal_layer(Void*) : WGPUSurfaceId
  fun wgpu_create_surface_from_wayland(Void*, Void*) : WGPUSurfaceId
  fun wgpu_create_surface_from_windows_hwnd(Void*, Void*) : WGPUSurfaceId
  fun wgpu_create_surface_from_xlib(Void**, UInt32) : WGPUSurfaceId
  fun wgpu_device_create_bind_group(WGPUDeviceId, WGPUBindGroupDescriptor*) : WGPUBindGroupId
  fun wgpu_device_create_bind_group_layout(WGPUDeviceId, WGPUBindGroupLayoutDescriptor*) : WGPUBindGroupLayoutId
  fun wgpu_device_create_buffer(WGPUDeviceId, WGPUBufferDescriptor*) : WGPUBufferId
  fun wgpu_device_create_command_encoder(WGPUDeviceId, WGPUCommandEncoderDescriptor*) : WGPUCommandEncoderId
  fun wgpu_device_create_compute_pipeline(WGPUDeviceId, WGPUComputePipelineDescriptor*) : WGPUComputePipelineId
  fun wgpu_device_create_pipeline_layout(WGPUDeviceId, WGPUPipelineLayoutDescriptor*) : WGPUPipelineLayoutId
  fun wgpu_device_create_render_bundle_encoder(WGPUDeviceId, WGPURenderBundleEncoderDescriptor*) : WGPURenderBundleEncoderId
  fun wgpu_device_create_render_pipeline(WGPUDeviceId, WGPURenderPipelineDescriptor*) : WGPURenderPipelineId
  fun wgpu_device_create_sampler(WGPUDeviceId, WGPUSamplerDescriptor*) : WGPUSamplerId
  fun wgpu_device_create_shader_module(WGPUDeviceId, WGPUShaderSource) : WGPUShaderModuleId
  fun wgpu_device_create_swap_chain(WGPUDeviceId, WGPUSurfaceId, WGPUSwapChainDescriptor*) : WGPUSwapChainId
  fun wgpu_device_create_texture(WGPUDeviceId, WGPUTextureDescriptor*) : WGPUTextureId
  fun wgpu_device_destroy(WGPUDeviceId) : Void
  fun wgpu_device_features(WGPUDeviceId) : WGPUFeatures
  fun wgpu_device_get_default_queue(WGPUDeviceId) : WGPUQueueId
  fun wgpu_device_limits(WGPUDeviceId) : WGPUCLimits
  fun wgpu_device_poll(WGPUDeviceId, Bool) : Void
  fun wgpu_get_version() : UInt32
  fun wgpu_pipeline_layout_destroy(WGPUPipelineLayoutId) : Void
  fun wgpu_queue_submit(WGPUQueueId, WGPUCommandBufferId*, LibC::SizeT) : Void
  fun wgpu_queue_write_buffer(WGPUQueueId, WGPUBufferId, WGPUBufferAddress, UInt8*, LibC::SizeT) : Void
  fun wgpu_queue_write_texture(WGPUQueueId, WGPUTextureCopyView*, UInt8*, LibC::SizeT, WGPUTextureDataLayout*, WGPUExtent3d*) : Void
  fun wgpu_render_bundle_destroy(WGPURenderBundleId) : Void
  fun wgpu_render_bundle_draw(WGPURenderBundleEncoder*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_bundle_draw_indexed(WGPURenderBundleEncoder*, UInt32, UInt32, UInt32, Int32, UInt32) : Void
  fun wgpu_render_bundle_draw_indirect(WGPURenderBundleEncoder*, WGPUBufferId, WGPUBufferAddress) : Void
  fun wgpu_render_bundle_encoder_finish(WGPURenderBundleEncoderId, WGPURenderBundleDescriptor_Label*) : WGPURenderBundleId
  fun wgpu_render_bundle_insert_debug_marker(WGPURenderBundleEncoder*, WGPURawString) : Void
  fun wgpu_render_bundle_pop_debug_group(WGPURenderBundleEncoder*) : Void
  fun wgpu_render_bundle_push_debug_group(WGPURenderBundleEncoder*, WGPURawString) : Void
  fun wgpu_render_bundle_set_bind_group(WGPURenderBundleEncoder*, UInt32, WGPUBindGroupId, WGPUDynamicOffset*, LibC::SizeT) : Void
  fun wgpu_render_bundle_set_index_buffer(WGPURenderBundleEncoder*, WGPUBufferId, WGPUBufferAddress, WGPUOption_BufferSize) : Void
  fun wgpu_render_bundle_set_pipeline(WGPURenderBundleEncoder*, WGPURenderPipelineId) : Void
  fun wgpu_render_bundle_set_vertex_buffer(WGPURenderBundleEncoder*, UInt32, WGPUBufferId, WGPUBufferAddress, WGPUOption_BufferSize) : Void
  fun wgpu_render_pass_bundle_indexed_indirect(WGPURenderBundleEncoder*, WGPUBufferId, WGPUBufferAddress) : Void
  fun wgpu_render_pass_destroy(WGPURenderPass*) : Void
  fun wgpu_render_pass_draw(WGPURenderPass*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_draw_indexed(WGPURenderPass*, UInt32, UInt32, UInt32, Int32, UInt32) : Void
  fun wgpu_render_pass_draw_indexed_indirect(WGPURenderPass*, WGPUBufferId, WGPUBufferAddress) : Void
  fun wgpu_render_pass_draw_indirect(WGPURenderPass*, WGPUBufferId, WGPUBufferAddress) : Void
  fun wgpu_render_pass_end_pass(WGPURenderPass*) : Void
  fun wgpu_render_pass_insert_debug_marker(WGPURenderPass*, WGPURawString, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indexed_indirect(WGPURenderPass*, WGPUBufferId, WGPUBufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indexed_indirect_count(WGPURenderPass*, WGPUBufferId, WGPUBufferAddress, WGPUBufferId, WGPUBufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indirect(WGPURenderPass*, WGPUBufferId, WGPUBufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indirect_count(WGPURenderPass*, WGPUBufferId, WGPUBufferAddress, WGPUBufferId, WGPUBufferAddress, UInt32) : Void
  fun wgpu_render_pass_pop_debug_group(WGPURenderPass*) : Void
  fun wgpu_render_pass_push_debug_group(WGPURenderPass*, WGPURawString, UInt32) : Void
  fun wgpu_render_pass_set_bind_group(WGPURenderPass*, UInt32, WGPUBindGroupId, WGPUDynamicOffset*, LibC::SizeT) : Void
  fun wgpu_render_pass_set_blend_color(WGPURenderPass*, WGPUColor*) : Void
  fun wgpu_render_pass_set_index_buffer(WGPURenderPass*, WGPUBufferId, WGPUBufferAddress, WGPUOption_BufferSize) : Void
  fun wgpu_render_pass_set_pipeline(WGPURenderPass*, WGPURenderPipelineId) : Void
  fun wgpu_render_pass_set_scissor_rect(WGPURenderPass*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_set_stencil_reference(WGPURenderPass*, UInt32) : Void
  fun wgpu_render_pass_set_vertex_buffer(WGPURenderPass*, UInt32, WGPUBufferId, WGPUBufferAddress, WGPUOption_BufferSize) : Void
  fun wgpu_render_pass_set_viewport(WGPURenderPass*, Float32, Float32, Float32, Float32, Float32, Float32) : Void
  fun wgpu_render_pipeline_destroy(WGPURenderPipelineId) : Void
  fun wgpu_request_adapter_async(WGPURequestAdapterOptions*, WGPUBackendBit, Bool, WGPURequestAdapterCallback, Void*) : Void
  fun wgpu_sampler_destroy(WGPUSamplerId) : Void
  fun wgpu_set_log_callback(WGPULogCallback) : Void
  fun wgpu_set_log_level(WGPULogLevel) : Int32
  fun wgpu_shader_module_destroy(WGPUShaderModuleId) : Void
  fun wgpu_swap_chain_get_next_texture(WGPUSwapChainId) : WGPUSwapChainOutput
  fun wgpu_swap_chain_present(WGPUSwapChainId) : Void
  fun wgpu_texture_create_view(WGPUTextureId, WGPUTextureViewDescriptor*) : WGPUTextureViewId
  fun wgpu_texture_destroy(WGPUTextureId) : Void
  fun wgpu_texture_view_destroy(WGPUTextureViewId) : Void
end
