-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.adj_closure
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra




open Finset

variable {L : Type*} [LieRing L]


theorem BookProof.ChapterGaugeAdjointAlgebra.adj_closure (θ η X : L) :
    adjVar η (adjVar θ X) - adjVar θ (adjVar η X) = adjVar ⁅θ, η⁆ X := by sorry
