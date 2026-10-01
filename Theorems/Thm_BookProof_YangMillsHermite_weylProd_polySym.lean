-- Generated from ChapterYangMillsHermite.lean — theorem BookProof.YangMillsHermite.weylProd_polySym
import Mathlib
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsHermite

variable {d : ℕ}
variable {D : Submodule ℂ (L2d d)}
variable {D : Submodule ℂ (L2d 99)}



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

theorem BookProof.YangMillsHermite.weylProd_polySym {S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)}
    (hS : PolySym S) (hT : PolySym T) : PolySym (weylProd S T) := by sorry
