-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.scalaron_fock_mass_gap
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Theorems.Thm_BookProof_ScalaronFockGapChain_const_fock_gap
import Theorems.Thm_BookProof_ScalaronFockGapChain_const_fock_mass_gap
import Theorems.Thm_BookProof_ScalaronFockGapChain_scalaronMass_pos
open BookProof.ScalaronFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {alpha : ℝ} (halpha : 0 < alpha) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (opCol hermiteBasis (scalaronOnePart alpha)))
          A) ∧
      dGamma (opCol hermiteBasis (scalaronOnePart alpha)) vac = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        scalaronMass alpha * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u)
              (toLp (dGamma (opCol hermiteBasis (scalaronOnePart alpha)) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u)
            (toLp (dGamma (opCol hermiteBasis (scalaronOnePart alpha)) u)) : ℂ).re := by

  obtain ⟨hfried, hvac, hpos⟩ := const_fock_mass_gap hermiteBasis (scalaronMass_pos halpha)
  obtain ⟨-, hgap⟩ := const_fock_gap hermiteBasis (scalaronMass_pos halpha).le
  exact ⟨hfried, hvac, hgap, hpos⟩
