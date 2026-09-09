-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.ym_hermCol_band_bounds
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
import Theorems.Thm_BookProof_YangMillsBandBounds_ymHermCol_eq
import Theorems.Thm_BookProof_YangMillsBandBounds_isBandR4_ymPoly
import Theorems.Thm_BookProof_YangMillsBandBounds_gradedBand_of_isBandR
open BookProof.YangMillsBandBounds













noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (ymHermCol e fabc k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (ymHermCol e fabc k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ 4) ∧
      (∀ k j, ‖ymHermCol e fabc k j‖ ≤ C * (((e k).degree : ℝ) + 1) ^ 2) := by

  obtain ⟨M, C, hC, hcard, hband, hent⟩ :=
    gradedBand_of_isBandR e (isBandR4_ymPoly fabc)
  refine ⟨M, C, hC, ?_, ?_, ?_⟩
  · intro k; rw [ymHermCol_eq]; exact hcard k
  · intro k j hj; rw [ymHermCol_eq] at hj; exact hband k j hj
  · intro k j
    have hsq : Real.sqrt (((e k).degree : ℝ) + 1) ^ 4 = (((e k).degree : ℝ) + 1) ^ 2 := by
      have h : Real.sqrt (((e k).degree : ℝ) + 1) ^ 2 = ((e k).degree : ℝ) + 1 :=
        Real.sq_sqrt (by positivity)
      calc Real.sqrt (((e k).degree : ℝ) + 1) ^ 4
          = (Real.sqrt (((e k).degree : ℝ) + 1) ^ 2) ^ 2 := by ring
        _ = (((e k).degree : ℝ) + 1) ^ 2 := by rw [h]
    rw [ymHermCol_eq, ← hsq]
    exact hent k j
