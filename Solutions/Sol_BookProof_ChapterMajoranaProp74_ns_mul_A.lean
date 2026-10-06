-- Generated from ChapterMajoranaProp74.lean — solution of BookProof.ChapterMajoranaProp74.ns_mul_A
import Mathlib
import Definitions.Def_ChapterMajoranaProp74
open BookProof.ChapterMajoranaProp74



open Matrix


open BookProof.ChapterMajoranaFourier
open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution {g ns : Matrix (Fin 4) (Fin 4) ℂ} (hns2 : ns * ns = -1) :
    ns * (ns * g) = -g := by

      rw [ ← Matrix.mul_assoc, hns2, neg_one_mul ]
