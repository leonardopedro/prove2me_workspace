-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.stepUp_eq_zero
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Definitions.Def_ChapterA4
open BookProof.ResolventLadderEq

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadderEq.stepUp_eq_zero {c δ t : ℝ} (hδ : 0 < δ) (h : t ≤ c - δ) : stepUp c δ t = 0 := by sorry
