-- Generated from ChapterSirkSpectralGeometry.lean — solution of BookProof.ChapterSirkSpectralGeometry.convex_realSegment
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
open BookProof.ChapterSirkSpectralGeometry









noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) : Convex ℝ (realSegment a b) := by

  rintro x ⟨hxi, hxl, hxu⟩ y ⟨hyi, hyl, hyu⟩ s t hs ht hst
  have him : (s • x + t • y : ℂ).im = 0 := by
    simp [Complex.real_smul, hxi, hyi]
  have hre : (s • x + t • y : ℂ).re = s * x.re + t * y.re := by
    simp [Complex.real_smul, Complex.mul_re, hxi, hyi]
  have hsa : s * a + t * a = a := by rw [← add_mul, hst, one_mul]
  have hsb : s * b + t * b = b := by rw [← add_mul, hst, one_mul]
  refine ⟨him, ?_, ?_⟩ <;> rw [hre]
  · linarith [mul_le_mul_of_nonneg_left hxl hs, mul_le_mul_of_nonneg_left hyl ht]
  · linarith [mul_le_mul_of_nonneg_left hxu hs, mul_le_mul_of_nonneg_left hyu ht]
