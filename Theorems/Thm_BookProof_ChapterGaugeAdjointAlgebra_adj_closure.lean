-- Generated from ChapterGaugeAdjointAlgebra.lean — theorem BookProof.ChapterGaugeAdjointAlgebra.adj_closure
import Mathlib
import Definitions.Def_ChapterGaugeAdjointAlgebra
open BookProof.ChapterGaugeAdjointAlgebra

variable {L : Type*} [LieRing L]




open Finset


theorem BookProof.ChapterGaugeAdjointAlgebra.adj_closure (θ η X : L) :
    adjVar η (adjVar θ X) - adjVar θ (adjVar η X) = adjVar ⁅θ, η⁆ X := by sorry
