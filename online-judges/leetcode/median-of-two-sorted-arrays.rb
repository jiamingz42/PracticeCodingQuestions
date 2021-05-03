def find_median_sorted_arrays(nums1, nums2)

    len1, len2 = nums1.size, nums2.size

    return nil if len1 == 0 and len2 == 0
    return find_median_sorted_arrays(nums2, nums1)  if len1 > len2

    i = find_partition(nums1, nums2)
    j = (len1+len2)/2-i

    right_bucket_min = find_min(
        i < len1 ? nums1[i] : nil,
        j < len2 ? nums2[j] : nil,
    )
    return right_bucket_min if (len1+len2) % 2 == 1

    left_bucket_max = find_max(
        i > 0 ? nums1[i-1] : nil,
        j > 0 ? nums2[j-1] : nil,
    )
    return 1.0*(left_bucket_max+right_bucket_min)/2
end

# assume nums1.size <= nums2.size
def find_partition(nums1, nums2)
    len1, len2 = nums1.size, nums2.size
    lo, hi = 0, len1
    while (lo <= hi) do
        i = lo+(hi-lo)/2
        j = (len1+len2)/2-i
        if i > 0 and j < len2 and nums1[i-1] > nums2[j]
          hi = i-1
        elsif j > 0 and i < len1 and nums2[j-1] > nums1[i]
          lo = i+1
        else
          return i
        end
    end
end

def find_max(num1, num2)
    [num1,num2].select { |v| !v.nil? }.max
end

def find_min(num1, num2)
    [num1,num2].select { |v| !v.nil? }.min
end
