-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.stepUp_eq_zero
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
open BookProof.ResolventLadderEq

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadderEq.stepUp_eq_zero {c δ t : ℝ} (hδ : 0 < δ) (h : t ≤ c - δ) : stepUp c δ t = 0 := by sorry
