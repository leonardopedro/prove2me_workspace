-- Generated from ChapterWeylSL2Group.lean — theorem BookProof.ChapterWeylSL2Group.isExpOfSl2_stdRep
import Definitions.Def_ChapterWeylSl2
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed
open BookProof.ChapterWeylSL2Group



open BookProof.ChapterWeylSl2

universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V} {R : Sl2Rep V} {N : ℕ}

theorem BookProof.ChapterWeylSL2Group.isExpOfSl2_stdRep : IsExpOfSl2 stdRep stdSl2 2 where
  two_le := by sorry
