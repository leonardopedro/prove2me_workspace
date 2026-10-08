-- Generated from ChapterA1h.lean — theorem BookProof.ChapterA.HasQuaternionicRImaginary.hasCommutingRImaginary
import Definitions.Def_Complexification
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


theorem BookProof.ChapterA.HasQuaternionicRImaginary.hasCommutingRImaginary {M : System ℝ W}
    (h : HasQuaternionicRImaginary M) : HasCommutingRImaginary M := by sorry
