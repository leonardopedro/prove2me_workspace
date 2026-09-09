-- Generated from ChapterYangMillsBandBounds.lean — solution of BookProof.YangMillsBandBounds.gradedBand_of_isBandR
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
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
theorem solution {d r m : ℕ} (e : ℕ ≃ (Fin d →₀ ℕ))
    {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)} (h : IsBandR r m T) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (hermCol e T k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (hermCol e T k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ r) ∧
      (∀ k j, ‖hermCol e T k j‖ ≤ C * Real.sqrt (((e k).degree : ℝ) + 1) ^ m) := by

  classical
  obtain ⟨M, C, hC, hB⟩ := h
  choose F hFrep hFcard hFband hFcoef using fun α => hB α
  refine ⟨M, C, hC, ?_, ?_, ?_⟩
  · intro k
    have hsub : ∀ j ∈ (hermCol e T k).support, e j ∈ (F (e k)).support := by
      intro j hj
      have hne : hermCol e T k j ≠ 0 := Finsupp.mem_support_iff.mp hj
      rw [hermCol_eq_coef e (hFrep (e k)) j] at hne
      exact Finsupp.mem_support_iff.mpr hne
    refine le_trans (Finset.card_le_card_of_injOn e hsub ?_) (hFcard (e k))
    exact fun a _ b _ hab => e.injective hab
  · intro k j hj
    have hne : hermCol e T k j ≠ 0 := Finsupp.mem_support_iff.mp hj
    rw [hermCol_eq_coef e (hFrep (e k)) j] at hne
    exact hFband (e k) (e j) (Finsupp.mem_support_iff.mpr hne)
  · intro k j
    rw [hermCol_eq_coef e (hFrep (e k)) j]
    exact hFcoef (e k) (e j)
