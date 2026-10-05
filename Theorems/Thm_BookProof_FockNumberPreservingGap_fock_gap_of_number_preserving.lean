-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.fock_gap_of_number_preserving
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.FockNumberPreservingGap


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

theorem BookProof.FockNumberPreservingGap.fock_gap_of_number_preserving {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 ≤ mu)
    (hgap : IsPosCol (shiftCol col mu)) {u : FockAlg} (h0 : u 0 = 0) :
    mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by sorry
