@[Link(ldflags: "-L#{__DIR__}/../bin/libs -lwgpu_native")]
lib LibWGPU
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
  # WGPUColorWrite_RED = ( uint32_t)1
  # WGPUColorWrite_GREEN = ( uint32_t)2
  # WGPUColorWrite_BLUE = ( uint32_t)4
  # WGPUColorWrite_ALPHA = ( uint32_t)8
  # WGPUColorWrite_COLOR = ( uint32_t)7
  # WGPUColorWrite_ALL = ( uint32_t)15

  alias NonZeroU64 = UInt64
  alias Option_NonZeroU32 = UInt32
  alias Option_NonZeroU64 = UInt64
  alias Option_BufferSize = Option_NonZeroU64
  alias Option_AdapterId = UInt64
  alias Option_BufferId = UInt64
  alias Option_SamplerId = UInt64
  alias Option_SurfaceId = UInt64
  alias Option_TextureViewId = UInt64
  enum AddressMode : UInt8
    ClampToEdge = 0
    Repeat = 1
    MirrorRepeat = 2
  end
  enum Backend : UInt8
    Empty = 0
    Vulkan = 1
    Metal = 2
    Dx12 = 3
    Dx11 = 4
    Gl = 5
    BrowserWebGpu = 6
  end
  enum BindingType : UInt32
    UniformBuffer = 0
    StorageBuffer = 1
    ReadonlyStorageBuffer = 2
    Sampler = 3
    ComparisonSampler = 4
    SampledTexture = 5
    ReadonlyStorageTexture = 6
    WriteonlyStorageTexture = 7
  end
  enum BlendFactor : UInt8
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
  enum BlendOperation : UInt8
    Add = 0
    Subtract = 1
    ReverseSubtract = 2
    Min = 3
    Max = 4
  end
  enum BufferMapAsyncStatus : UInt8
    Success = 0
    Error = 1
    Unknown = 2
    ContextLost = 3
  end
  enum CDeviceType : UInt8
    Other = 0
    IntegratedGpu = 1
    DiscreteGpu = 2
    VirtualGpu = 3
    Cpu = 4
  end
  enum CompareFunction : UInt8
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
  enum CullMode : UInt8
    None = 0
    Front = 1
    Back = 2
  end
  enum FilterMode : UInt8
    Nearest = 0
    Linear = 1
  end
  enum FrontFace : UInt8
    Ccw = 0
    Cw = 1
  end
  enum IndexFormat : UInt8
    Uint16 = 0
    Uint32 = 1
  end
  enum InputStepMode : UInt8
    Vertex = 0
    Instance = 1
  end
  enum LoadOp : UInt8
    Clear = 0
    Load = 1
  end
  enum LogLevel : UInt8
    Off = 0
    Error = 1
    Warn = 2
    Info = 3
    Debug = 4
    Trace = 5
  end
  enum PowerPreference : UInt8
    Default = 0
    LowPower = 1
    HighPerformance = 2
  end
  enum PresentMode : UInt8
    Immediate = 0
    Mailbox = 1
    Fifo = 2
  end
  enum PrimitiveTopology : UInt8
    PointList = 0
    LineList = 1
    LineStrip = 2
    TriangleList = 3
    TriangleStrip = 4
  end
  enum SType : UInt32
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
  enum StencilOperation : UInt8
    Keep = 0
    Zero = 1
    Replace = 2
    Invert = 3
    IncrementClamp = 4
    DecrementClamp = 5
    IncrementWrap = 6
    DecrementWrap = 7
  end
  enum StoreOp : UInt8
    Clear = 0
    Store = 1
  end
  enum SwapChainStatus : UInt8
    Good = 0
    Suboptimal = 1
    Timeout = 2
    Outdated = 3
    Lost = 4
    OutOfMemory = 5
  end
  enum TextureAspect : UInt8
    All = 0
    StencilOnly = 1
    DepthOnly = 2
  end
  enum TextureComponentType : UInt8
    Float = 0
    Sint = 1
    Uint = 2
  end
  enum TextureDimension : UInt8
    D1 = 0
    D2 = 1
    D3 = 2
  end
  enum TextureFormat : UInt8
    # Normal 8 bit formats
    R8Unorm = 0
    R8Snorm = 1
    R8Uint = 2
    R8Sint = 3

    # Normal 16 bit formats
    R16Uint = 4
    R16Sint = 5
    R16Float = 6
    Rg8Unorm = 7
    Rg8Snorm = 8
    Rg8Uint = 9
    Rg8Sint = 10

    # Normal 32 bit formats
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

    # Packed 32 bit formats
    Rgb10a2Unorm = 24
    Rg11b10Float = 25

    # Normal 64 bit formats
    Rg32Uint = 26
    Rg32Sint = 27
    Rg32Float = 28
    Rgba16Uint = 29
    Rgba16Sint = 30
    Rgba16Float = 31

    # Normal 128 bit formats
    Rgba32Uint = 32
    Rgba32Sint = 33
    Rgba32Float = 34

    # Depth and stencil formats
    Depth32Float = 35
    Depth24Plus = 36
    Depth24PlusStencil8 = 37
  end
  enum TextureViewDimension : UInt8
    D1 = 0
    D2 = 1
    D2Array = 2
    Cube = 3
    CubeArray = 4
    D3 = 5
  end
  enum VertexFormat : UInt8
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
  type ComputePass = Void
  type RenderBundleEncoder = Void
  type RenderPass = Void
  alias AdapterId = NonZeroU64
  alias Features = UInt64
  struct CAdapterInfo
    name : Char*
    name_length : LibC::SizeT
    vendor : LibC::SizeT
    device : LibC::SizeT
    device_type : CDeviceType
    backend : Backend
  end
  struct CLimits
    max_bind_groups : UInt32
  end
  alias DeviceId = NonZeroU64
  alias BindGroupId = NonZeroU64
  alias BindGroupLayoutId = NonZeroU64
  alias BufferId = NonZeroU64
  alias BufferAddress = UInt64
  alias BufferSize = NonZeroU64
  alias BufferMapCallback = (BufferMapAsyncStatus, UInt8*) -> Void
  alias CommandBufferId = NonZeroU64
  alias CommandEncoderId = CommandBufferId
  struct ComputePassDescriptor
    todo : UInt32
  end
  alias TextureViewId = NonZeroU64
  struct Color
    r : Float64
    g : Float64
    b : Float64
    a : Float64
  end
  struct PassChannel_Color
    load_op : LoadOp
    store_op : StoreOp
    clear_value : Color
    read_only : Bool
  end
  struct RenderPassColorAttachmentDescriptorBase_TextureViewId
    attachment : TextureViewId
    resolve_target : Option_TextureViewId
    channel : PassChannel_Color
  end
  alias RenderPassColorAttachmentDescriptor = RenderPassColorAttachmentDescriptorBase_TextureViewId
  struct PassChannel_f32
    load_op : LoadOp
    store_op : StoreOp
    clear_value : Float32
    read_only : Bool
  end
  struct PassChannel_u32
    load_op : LoadOp
    store_op : StoreOp
    clear_value : UInt32
    read_only : Bool
  end
  struct RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId
    attachment : TextureViewId
    depth : PassChannel_f32
    stencil : PassChannel_u32
  end
  alias RenderPassDepthStencilAttachmentDescriptor = RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId
  struct RenderPassDescriptor
    color_attachments : RenderPassColorAttachmentDescriptor*
    color_attachments_length : LibC::SizeT
    depth_stencil_attachment : RenderPassDepthStencilAttachmentDescriptor*
  end
  struct TextureDataLayout
    offset : BufferAddress
    bytes_per_row : UInt32
    rows_per_image : UInt32
  end
  struct BufferCopyView
    buffer : BufferId
    layout : TextureDataLayout
  end
  alias TextureId = NonZeroU64
  struct Origin3d
    x : UInt32
    y : UInt32
    z : UInt32
  end
  struct TextureCopyView
    texture : TextureId
    mip_level : UInt32
    origin : Origin3d
  end
  struct Extent3d
    width : UInt32
    height : UInt32
    depth : UInt32
  end
  struct CommandBufferDescriptor
    todo : UInt32
  end
  alias RawString = Char*
  alias DynamicOffset = UInt32
  alias ComputePipelineId = NonZeroU64
  alias SurfaceId = NonZeroU64
  alias Label = Char*
  struct BindGroupEntry
    binding : UInt32
    buffer : Option_BufferId
    offset : BufferAddress
    size : BufferSize
    sampler : Option_SamplerId
    texture_view : Option_TextureViewId
  end
  struct BindGroupDescriptor
    label : Label
    layout : BindGroupLayoutId
    entries : BindGroupEntry*
    entries_length : LibC::SizeT
  end
  alias ShaderStage = UInt32
  struct BindGroupLayoutEntry
    binding : UInt32
    visibility : ShaderStage
    ty : BindingType
    has_dynamic_offset : Bool
    min_buffer_binding_size : Option_NonZeroU64
    multisampled : Bool
    view_dimension : TextureViewDimension
    texture_component_type : TextureComponentType
    storage_texture_format : TextureFormat
    count : Option_NonZeroU32
  end
  struct BindGroupLayoutDescriptor
    label : Label
    entries : BindGroupLayoutEntry*
    entries_length : LibC::SizeT
  end
  alias BufferUsage = UInt32
  struct BufferDescriptor
    label : Label
    size : BufferAddress
    usage : BufferUsage
    mapped_at_creation : Bool
  end
  struct CommandEncoderDescriptor
    label : Label
  end
  alias PipelineLayoutId = NonZeroU64
  alias ShaderModuleId = NonZeroU64
  struct ProgrammableStageDescriptor
    module : ShaderModuleId
    entry_point : RawString
  end
  struct ComputePipelineDescriptor
    layout : PipelineLayoutId
    compute_stage : ProgrammableStageDescriptor
  end
  struct PipelineLayoutDescriptor
    bind_group_layouts : BindGroupLayoutId*
    bind_group_layouts_length : LibC::SizeT
  end
  alias RenderBundleEncoderId = RenderBundleEncoder*
  struct RenderBundleEncoderDescriptor
    label : Label
    color_formats : TextureFormat*
    color_formats_length : LibC::SizeT
    depth_stencil_format : TextureFormat*
    sample_count : UInt32
  end
  alias RenderPipelineId = NonZeroU64
  struct RasterizationStateDescriptor
    front_face : FrontFace
    cull_mode : CullMode
    depth_bias : Int32
    depth_bias_slope_scale : Float32
    depth_bias_clamp : Float32
  end
  struct BlendDescriptor
    src_factor : BlendFactor
    dst_factor : BlendFactor
    operation : BlendOperation
  end
  alias ColorWrite = UInt32
  struct ColorStateDescriptor
    format : TextureFormat
    alpha_blend : BlendDescriptor
    color_blend : BlendDescriptor
    write_mask : ColorWrite
  end
  struct StencilStateFaceDescriptor
    compare : CompareFunction
    fail_op : StencilOperation
    depth_fail_op : StencilOperation
    pass_op : StencilOperation
  end
  struct DepthStencilStateDescriptor
    format : TextureFormat
    depth_write_enabled : Bool
    depth_compare : CompareFunction
    stencil_front : StencilStateFaceDescriptor
    stencil_back : StencilStateFaceDescriptor
    stencil_read_mask : UInt32
    stencil_write_mask : UInt32
  end
  alias ShaderLocation = UInt32
  struct VertexAttributeDescriptor
    offset : BufferAddress
    format : VertexFormat
    shader_location : ShaderLocation
  end
  struct VertexBufferLayoutDescriptor
    array_stride : BufferAddress
    step_mode : InputStepMode
    attributes : VertexAttributeDescriptor*
    attributes_length : LibC::SizeT
  end
  struct VertexStateDescriptor
    index_format : IndexFormat
    vertex_buffers : VertexBufferLayoutDescriptor*
    vertex_buffers_length : LibC::SizeT
  end
  struct RenderPipelineDescriptor
    layout : PipelineLayoutId
    vertex_stage : ProgrammableStageDescriptor
    fragment_stage : ProgrammableStageDescriptor*
    primitive_topology : PrimitiveTopology
    rasterization_state : RasterizationStateDescriptor*
    color_states : ColorStateDescriptor*
    color_states_length : LibC::SizeT
    depth_stencil_state : DepthStencilStateDescriptor*
    vertex_state : VertexStateDescriptor
    sample_count : UInt32
    sample_mask : UInt32
    alpha_to_coverage_enabled : Bool
  end
  alias SamplerId = NonZeroU64
  struct ChainedStruct
    next : ChainedStruct*
    s_type : SType
  end
  struct SamplerDescriptor
    next_in_chain : ChainedStruct*
    label : Label
    address_mode_u : AddressMode
    address_mode_v : AddressMode
    address_mode_w : AddressMode
    mag_filter : FilterMode
    min_filter : FilterMode
    mipmap_filter : FilterMode
    lod_min_clamp : Float32
    lod_max_clamp : Float32
    compare : CompareFunction
  end
  struct ShaderSource
    bytes : UInt32*
    length : LibC::SizeT
  end
  alias SwapChainId = NonZeroU64
  alias TextureUsage = UInt32
  struct SwapChainDescriptor
    usage : TextureUsage
    format : TextureFormat
    width : UInt32
    height : UInt32
    present_mode : PresentMode
  end
  struct TextureDescriptor
    label : Label
    size : Extent3d
    mip_level_count : UInt32
    sample_count : UInt32
    dimension : TextureDimension
    format : TextureFormat
    usage : TextureUsage
  end
  alias QueueId = DeviceId
  alias RenderBundleId = NonZeroU64
  struct RenderBundleDescriptor_Label
    label : Label
  end
  struct RequestAdapterOptions
    power_preference : PowerPreference
    compatible_surface : Option_SurfaceId
  end
  alias BackendBit = UInt32
  alias RequestAdapterCallback = (Option_AdapterId, Void*) -> Void
  alias LogCallback = (Int32, Char*) -> Void
  struct SwapChainOutput
    status : SwapChainStatus
    view_id : Option_TextureViewId
  end
  struct TextureViewDescriptor
    label : Label
    format : TextureFormat
    dimension : TextureViewDimension
    aspect : TextureAspect
    base_mip_level : UInt32
    level_count : UInt32
    base_array_layer : UInt32
    array_layer_count : UInt32
  end
  struct AnisotropicSamplerDescriptorExt
    next_in_chain : ChainedStruct*
    s_type : SType
    anisotropic_clamp : UInt8
  end
  fun wgpu_adapter_destroy(AdapterId) : Void
  fun wgpu_adapter_features(AdapterId) : Features
  fun wgpu_adapter_get_info(AdapterId, CAdapterInfo*) : Void
  fun wgpu_adapter_limits(AdapterId) : CLimits
  fun wgpu_adapter_request_device(AdapterId, Features, CLimits*, Bool, Char*) : DeviceId
  fun wgpu_bind_group_destroy(BindGroupId) : Void
  fun wgpu_bind_group_layout_destroy(BindGroupLayoutId) : Void
  fun wgpu_buffer_destroy(BufferId) : Void
  fun wgpu_buffer_get_mapped_range(BufferId, BufferAddress, BufferSize) : UInt8*
  fun wgpu_buffer_map_read_async(BufferId, BufferAddress, BufferAddress, BufferMapCallback, UInt8*) : Void
  fun wgpu_buffer_map_write_async(BufferId, BufferAddress, BufferAddress, BufferMapCallback, UInt8*) : Void
  fun wgpu_buffer_unmap(BufferId) : Void
  fun wgpu_command_buffer_destroy(CommandBufferId) : Void
  fun wgpu_command_encoder_begin_compute_pass(CommandEncoderId, ComputePassDescriptor*) : ComputePass*
  fun wgpu_command_encoder_begin_render_pass(CommandEncoderId, RenderPassDescriptor*) : RenderPass*
  fun wgpu_command_encoder_copy_buffer_to_buffer(CommandEncoderId, BufferId, BufferAddress, BufferId, BufferAddress, BufferAddress) : Void
  fun wgpu_command_encoder_copy_buffer_to_texture(CommandEncoderId, BufferCopyView*, TextureCopyView*, Extent3d*) : Void
  fun wgpu_command_encoder_copy_texture_to_buffer(CommandEncoderId, TextureCopyView*, BufferCopyView*, Extent3d*) : Void
  fun wgpu_command_encoder_copy_texture_to_texture(CommandEncoderId, TextureCopyView*, TextureCopyView*, Extent3d*) : Void
  fun wgpu_command_encoder_destroy(CommandEncoderId) : Void
  fun wgpu_command_encoder_finish(CommandEncoderId, CommandBufferDescriptor*) : CommandBufferId
  fun wgpu_compute_pass_destroy(ComputePass*) : Void
  fun wgpu_compute_pass_dispatch(ComputePass*, UInt32, UInt32, UInt32) : Void
  fun wgpu_compute_pass_dispatch_indirect(ComputePass*, BufferId, BufferAddress) : Void
  fun wgpu_compute_pass_end_pass(ComputePass*) : Void
  fun wgpu_compute_pass_insert_debug_marker(ComputePass*, RawString, UInt32) : Void
  fun wgpu_compute_pass_pop_debug_group(ComputePass*) : Void
  fun wgpu_compute_pass_push_debug_group(ComputePass*, RawString, UInt32) : Void
  fun wgpu_compute_pass_set_bind_group(ComputePass*, UInt32, BindGroupId, DynamicOffset*, LibC::SizeT) : Void
  fun wgpu_compute_pass_set_pipeline(ComputePass*, ComputePipelineId) : Void
  fun wgpu_compute_pipeline_destroy(ComputePipelineId) : Void
  fun wgpu_create_surface_from_android(Void*) : SurfaceId
  fun wgpu_create_surface_from_metal_layer(Void*) : SurfaceId
  fun wgpu_create_surface_from_wayland(Void*, Void*) : SurfaceId
  fun wgpu_create_surface_from_windows_hwnd(Void*, Void*) : SurfaceId
  fun wgpu_create_surface_from_xlib(Void**, UInt32) : SurfaceId
  fun wgpu_device_create_bind_group(DeviceId, BindGroupDescriptor*) : BindGroupId
  fun wgpu_device_create_bind_group_layout(DeviceId, BindGroupLayoutDescriptor*) : BindGroupLayoutId
  fun wgpu_device_create_buffer(DeviceId, BufferDescriptor*) : BufferId
  fun wgpu_device_create_command_encoder(DeviceId, CommandEncoderDescriptor*) : CommandEncoderId
  fun wgpu_device_create_compute_pipeline(DeviceId, ComputePipelineDescriptor*) : ComputePipelineId
  fun wgpu_device_create_pipeline_layout(DeviceId, PipelineLayoutDescriptor*) : PipelineLayoutId
  fun wgpu_device_create_render_bundle_encoder(DeviceId, RenderBundleEncoderDescriptor*) : RenderBundleEncoderId
  fun wgpu_device_create_render_pipeline(DeviceId, RenderPipelineDescriptor*) : RenderPipelineId
  fun wgpu_device_create_sampler(DeviceId, SamplerDescriptor*) : SamplerId
  fun wgpu_device_create_shader_module(DeviceId, ShaderSource) : ShaderModuleId
  fun wgpu_device_create_swap_chain(DeviceId, SurfaceId, SwapChainDescriptor*) : SwapChainId
  fun wgpu_device_create_texture(DeviceId, TextureDescriptor*) : TextureId
  fun wgpu_device_destroy(DeviceId) : Void
  fun wgpu_device_features(DeviceId) : Features
  fun wgpu_device_get_default_queue(DeviceId) : QueueId
  fun wgpu_device_limits(DeviceId) : CLimits
  fun wgpu_device_poll(DeviceId, Bool) : Void
  fun wgpu_get_version() : UInt32
  fun wgpu_pipeline_layout_destroy(PipelineLayoutId) : Void
  fun wgpu_queue_submit(QueueId, CommandBufferId*, LibC::SizeT) : Void
  fun wgpu_queue_write_buffer(QueueId, BufferId, BufferAddress, UInt8*, LibC::SizeT) : Void
  fun wgpu_queue_write_texture(QueueId, TextureCopyView*, UInt8*, LibC::SizeT, TextureDataLayout*, Extent3d*) : Void
  fun wgpu_render_bundle_destroy(RenderBundleId) : Void
  fun wgpu_render_bundle_draw(RenderBundleEncoder*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_bundle_draw_indexed(RenderBundleEncoder*, UInt32, UInt32, UInt32, Int32, UInt32) : Void
  fun wgpu_render_bundle_draw_indirect(RenderBundleEncoder*, BufferId, BufferAddress) : Void
  fun wgpu_render_bundle_encoder_finish(RenderBundleEncoderId, RenderBundleDescriptor_Label*) : RenderBundleId
  fun wgpu_render_bundle_insert_debug_marker(RenderBundleEncoder*, RawString) : Void
  fun wgpu_render_bundle_pop_debug_group(RenderBundleEncoder*) : Void
  fun wgpu_render_bundle_push_debug_group(RenderBundleEncoder*, RawString) : Void
  fun wgpu_render_bundle_set_bind_group(RenderBundleEncoder*, UInt32, BindGroupId, DynamicOffset*, LibC::SizeT) : Void
  fun wgpu_render_bundle_set_index_buffer(RenderBundleEncoder*, BufferId, BufferAddress, Option_BufferSize) : Void
  fun wgpu_render_bundle_set_pipeline(RenderBundleEncoder*, RenderPipelineId) : Void
  fun wgpu_render_bundle_set_vertex_buffer(RenderBundleEncoder*, UInt32, BufferId, BufferAddress, Option_BufferSize) : Void
  fun wgpu_render_pass_bundle_indexed_indirect(RenderBundleEncoder*, BufferId, BufferAddress) : Void
  fun wgpu_render_pass_destroy(RenderPass*) : Void
  fun wgpu_render_pass_draw(RenderPass*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_draw_indexed(RenderPass*, UInt32, UInt32, UInt32, Int32, UInt32) : Void
  fun wgpu_render_pass_draw_indexed_indirect(RenderPass*, BufferId, BufferAddress) : Void
  fun wgpu_render_pass_draw_indirect(RenderPass*, BufferId, BufferAddress) : Void
  fun wgpu_render_pass_end_pass(RenderPass*) : Void
  fun wgpu_render_pass_insert_debug_marker(RenderPass*, RawString, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indexed_indirect(RenderPass*, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indexed_indirect_count(RenderPass*, BufferId, BufferAddress, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indirect(RenderPass*, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_multi_draw_indirect_count(RenderPass*, BufferId, BufferAddress, BufferId, BufferAddress, UInt32) : Void
  fun wgpu_render_pass_pop_debug_group(RenderPass*) : Void
  fun wgpu_render_pass_push_debug_group(RenderPass*, RawString, UInt32) : Void
  fun wgpu_render_pass_set_bind_group(RenderPass*, UInt32, BindGroupId, DynamicOffset*, LibC::SizeT) : Void
  fun wgpu_render_pass_set_blend_color(RenderPass*, Color*) : Void
  fun wgpu_render_pass_set_index_buffer(RenderPass*, BufferId, BufferAddress, Option_BufferSize) : Void
  fun wgpu_render_pass_set_pipeline(RenderPass*, RenderPipelineId) : Void
  fun wgpu_render_pass_set_scissor_rect(RenderPass*, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_set_stencil_reference(RenderPass*, UInt32) : Void
  fun wgpu_render_pass_set_vertex_buffer(RenderPass*, UInt32, BufferId, BufferAddress, Option_BufferSize) : Void
  fun wgpu_render_pass_set_viewport(RenderPass*, Float32, Float32, Float32, Float32, Float32, Float32) : Void
  fun wgpu_render_pipeline_destroy(RenderPipelineId) : Void
  fun wgpu_request_adapter_async(RequestAdapterOptions*, BackendBit, Bool, RequestAdapterCallback, Void*) : Void
  fun wgpu_sampler_destroy(SamplerId) : Void
  fun wgpu_set_log_callback(LogCallback) : Void
  fun wgpu_set_log_level(LogLevel) : Int32
  fun wgpu_shader_module_destroy(ShaderModuleId) : Void
  fun wgpu_swap_chain_get_next_texture(SwapChainId) : SwapChainOutput
  fun wgpu_swap_chain_present(SwapChainId) : Void
  fun wgpu_texture_create_view(TextureId, TextureViewDescriptor*) : TextureViewId
  fun wgpu_texture_destroy(TextureId) : Void
  fun wgpu_texture_view_destroy(TextureViewId) : Void
end
