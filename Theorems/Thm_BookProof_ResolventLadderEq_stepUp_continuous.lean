-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.stepUp_continuous
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


theorem BookProof.ResolventLadderEq.stepUp_continuous (c δ : ℝ) : Continuous (stepUp c δ) := by sorry
