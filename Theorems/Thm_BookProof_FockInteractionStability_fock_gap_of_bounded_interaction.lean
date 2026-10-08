-- Generated from ChapterFockInteractionStability.lean — theorem BookProof.FockInteractionStability.fock_gap_of_bounded_interaction
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockInteractionStability


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow



variable {E : Type*} [NormedAddCommGroup E]


theorem BookProof.FockInteractionStability.fock_gap_of_bounded_interaction {col : ℕ → (ℕ →₀ ℂ)} {mu delta : ℝ} (hmu : 0 ≤ mu)
    (hgap : IsPosCol (shiftCol col mu)) (V : Fock →L[ℂ] Fock) (hV : ‖V‖ ≤ delta)
    {u : FockAlg} (h0 : u 0 = 0) :
    (mu - delta) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + (inner ℂ (toLp u) (V (toLp u)) : ℂ).re := by sorry
