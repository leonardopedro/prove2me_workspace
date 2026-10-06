-- Generated from ChapterMajoranaProp74.lean — theorem BookProof.ChapterMajoranaProp74.prop74_Rj_comm
import Definitions.Def_ChapterMajoranaFourier
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterMajoranaProp74
open BookProof.ChapterMajoranaProp74


open Matrix


open BookProof.ChapterMajoranaFourier
open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaProp74.prop74_Rj_comm (g ns : Matrix (Fin 4) (Fin 4) ℂ)
    (_hg2 : g * g = 1) (hgns : g * ns = -(ns * g)) (c s pj : ℝ) :
    Dmat g pj * Sinv (ns * g) c s = Sinv (ns * g) c s * Dmat g pj := by sorry
