-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.sq_le_mul_of_quadratic_nonneg
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
open BookProof.ResolventLadder


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.ResolventLadder.sq_le_mul_of_quadratic_nonneg {A B C : ℝ} (hC : 0 ≤ C)
    (h : ∀ t : ℝ, 0 ≤ A + 2 * t * B + t ^ 2 * C) : B ^ 2 ≤ A * C := by sorry
