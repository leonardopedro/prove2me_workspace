-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.mul_rayleigh_le_normSq_of_mem_range
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
open BookProof.RitzMinMax
open BookProof.ResolventLadderEq


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.ResolventLadderEq.mul_rayleigh_le_normSq_of_mem_range (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (q : ℝ → ℝ) (hq : Continuous q) (c : ℝ)
    (hbd : ∀ μ ∈ spectrum ℝ A, c * (μ * (q μ * q μ)) ≤ (μ * q μ) * (μ * q μ)) (y : F) :
    c * rayleighVal A (cfc q A y) ≤ ‖A (cfc q A y)‖ ^ 2 := by sorry
