-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.dgamma_conjTranspose
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.dgamma_conjTranspose (μ : Fin 4) :
    (dgamma μ)ᴴ = if μ = 0 then dgamma μ else -dgamma μ := by sorry
