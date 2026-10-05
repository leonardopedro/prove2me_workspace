-- Generated from ChapterQuantumGravityFock.lean — theorem BookProof.QuantumGravityFock.jwSign_insert_of_lt
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.QuantumGravityFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

theorem BookProof.QuantumGravityFock.jwSign_insert_of_lt {i j : ℕ} {α : FermConf} (h : i < j) (hi : i ∉ α) :
    jwSign j (insert i α) = - jwSign j α := by sorry
