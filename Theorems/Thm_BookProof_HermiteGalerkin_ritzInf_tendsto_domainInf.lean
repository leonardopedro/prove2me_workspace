-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.ritzInf_tendsto_domainInf
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HermiteGalerkin



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.HermiteGalerkin.ritzInf_tendsto_domainInf (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x) :
    Tendsto (fun m : ℕ => ritzInf H (galerkinSpan b (m + 1))) atTop
      (nhds (ritzInf H (finiteModeDomain b))) := by sorry
