-- Generated from ChapterYangMillsAbelianFockEsa.lean — theorem BookProof.YmAbelianFock.ymAbelianHermOp_eq
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterA4
open BookProof.ChapterF7
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QuadFockEsa
open BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsHermite

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core, and the `24` Weyl-ordered squares of the
-- Yang–Mills Hamiltonian, make the defeq checks of this identification expensive
theorem BookProof.YmAbelianFock.ymAbelianHermOp_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ymAbelianHermOp e = (coreRepHerm e).op ymAbelianPoly := by sorry
