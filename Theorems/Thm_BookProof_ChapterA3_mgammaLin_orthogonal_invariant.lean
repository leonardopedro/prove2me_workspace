-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgammaLin_orthogonal_invariant
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgammaLin_orthogonal_invariant {W : Submodule ℂ MajoranaSpace}
    (hW : ∀ μ, ∀ x ∈ W, mgammaLin μ x ∈ W) (μ : Fin 4) {y : MajoranaSpace} (hy : y ∈ Wᗮ) :
    mgammaLin μ y ∈ Wᗮ := by sorry
