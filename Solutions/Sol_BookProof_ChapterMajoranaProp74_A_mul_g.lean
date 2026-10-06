-- Generated from ChapterMajoranaProp74.lean — solution of BookProof.ChapterMajoranaProp74.A_mul_g
import Mathlib
import Definitions.Def_ChapterMajoranaProp74
open BookProof.ChapterMajoranaProp74



open Matrix


open BookProof.ChapterMajoranaFourier
open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution {g ns : Matrix (Fin 4) (Fin 4) ℂ} (hg2 : g * g = 1) :
    (ns * g) * g = ns := by

      rw [ mul_assoc, hg2, mul_one ]
