-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgamma_irreducible
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma_irreducible (W : Submodule ℂ MajoranaSpace)
    (hW : ∀ μ, ∀ x ∈ W, mgammaLin μ x ∈ W) : W = ⊥ ∨ W = ⊤ := by sorry
