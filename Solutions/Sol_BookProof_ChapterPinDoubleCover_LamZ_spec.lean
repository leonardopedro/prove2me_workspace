-- Generated from ChapterPinDoubleCover.lean — solution of BookProof.ChapterPinDoubleCover.LamZ_spec
import Mathlib
import Definitions.Def_ChapterPinDoubleCover
open BookProof.ChapterPinDoubleCover



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ S ∈ Omega, ∀ μ : Fin 4,
      mgammaZ μ * S = S * (∑ ν : Fin 4, (LamZ S) μ ν • mgammaZ ν) := by

  decide
