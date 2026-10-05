-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.fock_gap_of_number_preserving_op
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.FockNumberPreservingGap


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

theorem BookProof.FockNumberPreservingGap.fock_gap_of_number_preserving_op {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 ≤ mu)
    (hgap : IsPosCol (shiftCol col mu)) :
    dGammaOp col (fockEquiv vac) = 0 ∧
      ∀ x : lpFiniteModes Conf, (inner ℂ (toLp vac) ((x : Fock)) : ℂ) = 0 →
        mu * ‖(x : Fock)‖ ^ 2 ≤ quadForm (dGammaOp col) x := by sorry
