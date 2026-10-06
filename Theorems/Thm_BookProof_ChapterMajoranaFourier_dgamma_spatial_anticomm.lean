-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.dgamma_spatial_anticomm
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.dgamma_spatial_anticomm (i j : Fin 3) (h : i ≠ j) :
    dgamma i.succ * dgamma j.succ = -(dgamma j.succ * dgamma i.succ) := by sorry
