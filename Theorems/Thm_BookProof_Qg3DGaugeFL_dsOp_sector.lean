-- Generated from ChapterQg3DGaugeFarisLavine.lean — theorem BookProof.Qg3DGaugeFL.dsOp_sector
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterA4
open BookProof.DirectSumEsa
open BookProof.Qg3DGaugeFL

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}



open BookProof.QuantumGravity3DGauge BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock BookProof.FarisLavineOnly
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.Qg3DGaugeFL.dsOp_sector (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) (i : ι) :
    ((dsOp H x : lp G 2) : ∀ i, G i) i = H i ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ := by sorry
