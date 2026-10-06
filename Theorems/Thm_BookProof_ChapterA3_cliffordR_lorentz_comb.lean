-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.cliffordR_lorentz_comb
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.cliffordR_lorentz_comb (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : Λ ∈ LorentzO) :
    IsCliffordR (fun μ => ∑ ν, Λ μ ν • mgammaR ν) := by sorry
