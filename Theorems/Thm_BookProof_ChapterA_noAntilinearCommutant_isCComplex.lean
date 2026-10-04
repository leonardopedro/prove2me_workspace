-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.noAntilinearCommutant_isCComplex
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.noAntilinearCommutant_isCComplex {M : System ℂ V} [Nontrivial V]
    (h : NoAntilinearCommutant M) : IsCComplex M := by sorry
