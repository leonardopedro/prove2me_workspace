-- Generated from ChapterNavierStokesLagrangianCanonical.lean — theorem BookProof.NavierStokesFlow.LagrangianCanonical.ann_comp_cre_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical
















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

theorem BookProof.NavierStokesFlow.LagrangianCanonical.ann_comp_cre_eq (i : Fin 3) :
    (ann i).comp (cre i) = (cre i).comp (ann i) + LinearMap.id := by sorry
