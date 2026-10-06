-- Generated from ChapterA3b.lean — theorem BookProof.ChapterA3.isCliffordC_toC
import Mathlib
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.isCliffordC_toC {A : Fin 4 → Matrix (Fin 4) (Fin 4) ℝ} (hA : IsCliffordR A) :
    IsCliffordC (fun μ => toC (A μ)) := by sorry
