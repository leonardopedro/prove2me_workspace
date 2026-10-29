-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.rayleighVal_le_of_cfc_eq_zero
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzPerturbation
import Definitions.Def_ChapterVonNeumannCore
open BookProof.RitzMinMax


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum
open BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.ResolventLadderEq.rayleighVal_le_of_cfc_eq_zero (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (q : ℝ → ℝ) (hq : Continuous q) (c : ℝ)
    (hbd : ∀ μ ∈ spectrum ℝ A, μ ≤ c + μ * q μ) {x : F} (hx : cfc q A x = 0) :
    rayleighVal A x ≤ c * ‖x‖ ^ 2 := by sorry
