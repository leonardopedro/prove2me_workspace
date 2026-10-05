-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.hermiteCoreOp_not_bounded
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteLp_mem_hermiteCore
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_hermiteLp
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) (hlam : ∀ C : ℝ, ∃ n, C < |lam n|) :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore, ‖hermiteCoreOp lam f‖ ≤ C * ‖(f : L2R)‖ := by

  rintro ⟨C, hC⟩
  obtain ⟨n, hn⟩ := hlam C
  have hnorm : ‖hermiteLp n‖ = 1 := by
    simpa using orthonormal_hermiteLp.norm_eq_one n
  have h := hC ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
  rw [hermiteCoreOp_hermiteLp, norm_smul] at h
  simp only [hnorm, mul_one, Complex.norm_real, Real.norm_eq_abs] at h
  exact absurd h (not_le.mpr hn)
