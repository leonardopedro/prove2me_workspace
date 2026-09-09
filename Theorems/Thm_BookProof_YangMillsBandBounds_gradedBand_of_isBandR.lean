-- Generated from ChapterYangMillsBandBounds.lean — theorem BookProof.YangMillsBandBounds.gradedBand_of_isBandR
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

theorem BookProof.YangMillsBandBounds.gradedBand_of_isBandR {d r m : ℕ} (e : ℕ ≃ (Fin d →₀ ℕ))
    {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)} (h : IsBandR r m T) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (hermCol e T k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (hermCol e T k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ r) ∧
      (∀ k j, ‖hermCol e T k j‖ ≤ C * Real.sqrt (((e k).degree : ℝ) + 1) ^ m) := by sorry
