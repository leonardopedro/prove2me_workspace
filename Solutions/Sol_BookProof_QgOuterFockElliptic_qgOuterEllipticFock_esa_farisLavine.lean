-- Generated from ChapterQgOuterFockEllipticFL.lean — solution of BookProof.QgOuterFockElliptic.qgOuterEllipticFock_esa_farisLavine
import Mathlib
import Definitions.Def_ChapterQgOuterFockEllipticFL
import Theorems.Thm_BookProof_QgOuterFockElliptic_outer_esa_farisLavine
import Theorems.Thm_BookProof_QgOuterFockElliptic_outer_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgKappaElliptic_nonneg
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterYangMillsFriedrichs
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
open BookProof.HermiteProductCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : ℕ}
variable {I : Type*} {G : I → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] [∀ i, CompleteSpace (G i)]

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn qgOuterEllipticDom qgOuterEllipticH ∧
      IsPositiveSelfAdjointExtension qgOuterEllipticHam qgOuterEllipticH := ⟨outer_esa_farisLavine _, outer_isPositiveSelfAdjointExtension _⟩
