-- Generated from ChapterQgOuterFockEllipticFL.lean — theorem BookProof.QgOuterFockElliptic.dsFriedComparison_isPositiveSelfAdjointExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgOuterFockEsa
import Mathlib
import Definitions.Def_ChapterQgOuterFockEllipticFL
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.DirectSumEsa
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs
open BookProof.QgOuterFockElliptic


open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuantumGravity3DGauge
open BookProof.QgOuterFock
open BookProof.QgOuterFockFL
open BookProof.DirectSumEsa
open BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : ℕ}
variable {I : Type*} {G : I → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] [∀ i, CompleteSpace (G i)]

theorem BookProof.QgOuterFockElliptic.dsFriedComparison_isPositiveSelfAdjointExtension (S : ∀ i, PosSymOp (G i))
    (hd : ∀ i, Dense ((S i).dom : Set (G i))) :
    IsPositiveSelfAdjointExtension (dsOp fun i => (S i).op) (dsFriedComparison S hd).op := by sorry
