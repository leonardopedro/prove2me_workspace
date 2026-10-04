-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.fock_gap_of_one_particle_form_gap_pair
import Definitions.Def_ChapterFockOneParticleGap
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterA4
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.FockPairPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockFieldPerturbation

theorem BookProof.FockPairPerturbation.fock_gap_of_one_particle_form_gap_pair (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b) {mu : ℝ} (hmu : 0 < mu)
    (hform : ∀ x : finiteModeDomain b,
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x)
    {f g : ℕ →₀ ℂ} (hfg : 2 * Real.sqrt 2 * (l2norm f * l2norm g) ≤ mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    (mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b A) u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re := by sorry
