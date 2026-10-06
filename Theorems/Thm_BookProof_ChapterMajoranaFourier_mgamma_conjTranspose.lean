-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.mgamma_conjTranspose
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.mgamma_conjTranspose (μ : Fin 4) :
    (mgamma μ)ᴴ = if μ = 0 then -mgamma μ else mgamma μ := by sorry
