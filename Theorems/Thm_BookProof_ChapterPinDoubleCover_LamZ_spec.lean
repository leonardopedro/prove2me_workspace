-- Generated from ChapterPinDoubleCover.lean — theorem BookProof.ChapterPinDoubleCover.LamZ_spec
import Mathlib
import Definitions.Def_ChapterPinDoubleCover
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterPinDoubleCover


open Matrix


open BookProof.ChapterA3
open Classical

theorem BookProof.ChapterPinDoubleCover.LamZ_spec :
    ∀ S ∈ Omega, ∀ μ : Fin 4,
      mgammaZ μ * S = S * (∑ ν : Fin 4, (LamZ S) μ ν • mgammaZ ν) := by sorry
