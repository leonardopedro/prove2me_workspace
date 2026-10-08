-- Generated from ChapterQgOuterFockEllipticFL.lean — theorem BookProof.QgOuterFockElliptic.qgOuterEllipticFock_esa_farisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterQgOuterFockEllipticFL
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.HermiteProductCore
open BookProof.QgOuterFock
open BookProof.QuantumGravity3DGauge
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

theorem BookProof.QgOuterFockElliptic.qgOuterEllipticFock_esa_farisLavine :
    EssentiallySelfAdjointOn qgOuterEllipticDom qgOuterEllipticH ∧
      IsPositiveSelfAdjointExtension qgOuterEllipticHam qgOuterEllipticH := by sorry
