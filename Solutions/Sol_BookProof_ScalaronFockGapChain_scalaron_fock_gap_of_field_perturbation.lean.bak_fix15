-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.scalaron_fock_gap_of_field_perturbation
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Theorems.Thm_BookProof_ScalaronFockGapChain_const_fock_gap_of_field_perturbation
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
theorem solution {alpha : ℝ} (halpha : 0 < alpha)
    {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < scalaronMass alpha) {u : FockAlg} (h0 : u 0 = 0) :
    0 < scalaronMass alpha - 2 * l2norm f ∧
      (scalaronMass alpha - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u)
              (toLp (dGamma (opCol hermiteBasis (scalaronOnePart alpha)) u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := const_fock_gap_of_field_perturbation hermiteBasis (scalaronMass_pos halpha) hf h0
