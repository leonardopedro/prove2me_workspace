-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.gradedBand_of_isBand2
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
open BookProof.QuadFockEsa

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}

theorem BookProof.QuadFockEsa.gradedBand_of_isBand2 (e : ℕ ≃ (Fin d →₀ ℕ))
    {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)} (h : IsBand2 T) :
    ∃ (M : ℕ) (C : ℝ), 0 ≤ C ∧
      (∀ k, (hermCol e T k).support.card ≤ M) ∧
      (∀ k, ∀ j ∈ (hermCol e T k).support,
        (((e j).degree : ℤ) - ((e k).degree : ℤ)).natAbs ≤ 2) ∧
      (∀ k j, ‖hermCol e T k j‖ ≤ C * (((e k).degree : ℝ) + 1)) := by sorry
