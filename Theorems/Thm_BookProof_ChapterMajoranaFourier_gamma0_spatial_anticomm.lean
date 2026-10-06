-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.gamma0_spatial_anticomm
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.gamma0_spatial_anticomm (i : Fin 3) :
    dgamma 0 * dgamma i.succ = -(dgamma i.succ * dgamma 0) := by sorry
