-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.hasCompactSupport_comp_realProd
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {F : ℂ → ℂ} (hF : HasCompactSupport F) :
    HasCompactSupport (fun p : ℝ × ℝ => F ((p.1 : ℂ) + p.2 * Complex.I)) := by

  obtain ⟨M, hM⟩ := hF.isCompact.isBounded.subset_closedBall 0
  refine HasCompactSupport.of_support_subset_isCompact
    ((isCompact_Icc (a := -M) (b := M)).prod (isCompact_Icc (a := -M) (b := M))) ?_
  rintro ⟨x, y⟩ hxy
  have hmem : ((x : ℂ) + y * Complex.I) ∈ tsupport F := subset_tsupport F hxy
  have hb := hM hmem
  simp only [mem_closedBall, dist_zero_right] at hb
  have hx : |x| ≤ ‖(x : ℂ) + y * Complex.I‖ := by
    have hre : ((x : ℂ) + y * Complex.I).re = x := by simp
    calc |x| = |((x : ℂ) + y * Complex.I).re| := by rw [hre]
      _ ≤ _ := Complex.abs_re_le_norm _
  have hy : |y| ≤ ‖(x : ℂ) + y * Complex.I‖ := by
    have him : ((x : ℂ) + y * Complex.I).im = y := by simp
    calc |y| = |((x : ℂ) + y * Complex.I).im| := by rw [him]
      _ ≤ _ := Complex.abs_im_le_norm _
  have hx' := abs_le.1 (hx.trans hb)
  have hy' := abs_le.1 (hy.trans hb)
  exact ⟨mem_Icc.2 ⟨hx'.1, hx'.2⟩, mem_Icc.2 ⟨hy'.1, hy'.2⟩⟩
