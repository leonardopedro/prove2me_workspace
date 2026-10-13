-- Generated from ChapterQg3DGaugeFarisLavine.lean — solution of BookProof.Qg3DGaugeFL.qgGauge_number_conserving
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Theorems.Thm_BookProof_Qg3DGaugeFL_dsOp_number_conserving
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterFarisLavineOnly
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.Qg3DGaugeFL




open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore
open BookProof.QgOuterFock

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

set_option maxHeartbeats 1000000 in
theorem solution (x : qgOuterCore) {n : ℕ}
    (hx : ∀ m, m ≠ n → ((x : qgOuterFock) : ∀ m : ℕ, L2d (m * 84)) m = 0) (m : ℕ) (hm : m ≠ n) :
    ((qgGaugeOuterHam x : qgOuterFock) : ∀ m : ℕ, L2d (m * 84)) m = 0 := dsOp_number_conserving _ x hx m hm
